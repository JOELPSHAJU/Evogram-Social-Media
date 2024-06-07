import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:evogram/core/sharedpreferences.dart';
import 'package:evogram/core/urls.dart';
import 'package:evogram/presentation/widgets/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_manager/photo_manager.dart';

class PostRepo {
  //fetchpost
  static Future fetchPost() async {
    var client = http.Client();

    final token = await getUserToken();
    try {
      var response =
          await client.get(Uri.parse('$baseurl$fetchposturl'), headers: {
        'content_Type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      debugPrint('statuscode:${response.statusCode}');
      return response;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //fetch followers post
  static Future fetchfollowespost({required int n}) async {
    var client = http.Client();
    final token = await getUserToken();
    try {
      var respose = await client.get(
          Uri.parse('$baseurl$followersposturl?page=$n&pageSize=10'),
          headers: {
            'content_Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint('statuscode:${respose.statusCode}');
      return respose;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //fetchuserby id
  static Future fetchuserpost({required String userid}) async {
    var client = http.Client();
    // final userid = await getUserId();
    try {
      var response = await client.get(
          Uri.parse('$baseurl$fetchuserposturl/$userid'),
          headers: {'content_Type': 'application/json'});
      debugPrint('statuscode:${response.statusCode}');
      return response;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //add post
  static Future<String> addpost(
      {required AssetEntity image, required String description}) async {
    var client = http.Client();
    try {
      final imageUrl = await uploadImage(await image.file);
      final token = await getUserToken();
      final userId = await getUserId();
      final userpost = {
        'imageUrl': imageUrl,
        'description': description,
        'userId': userId
      };

      var response = await client.post(Uri.parse('$baseurl$addposturl'),
          body: jsonEncode(userpost),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint('statuscode:${response.statusCode}');
      debugPrint(response.body);
      final responsebody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return 'post created successfully';
      } else if (responsebody['message'] ==
          'Something went wrong while saving to the database') {
        return 'Something went wrong while saving to the database';
      } else if (responsebody['message'] ==
          'Something went wrong on the server') {
        return 'Something went wrong on the server';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //deletepost
  static Future<String> deletepost({required String postid}) async {
    debugPrint('postid:$postid');
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client
          .delete(Uri.parse('$baseurl$deleteposturln/$postid'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint('statuscode:${response.statusCode}');
      if (response.statusCode == 200) {
        return 'post deleted successfully';
      } else if (response.statusCode == 500) {
        return 'internal server error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //updatepost
  static Future<String> editpost(
      {String? imageurl,
      File? image,
      required String description,
      required String postid}) async {
    var client = http.Client();
    try {
      debugPrint('url:$imageurl');
      debugPrint('imge:$image');
      final imageUrl = image != null ? await uploadImage(image) : imageurl;
      final usereditpost = {
        'imageUrl': imageUrl,
        'description': description,
      };
      final token = await getUserToken();
      var response = await client.put(Uri.parse('$baseurl$editposturl/$postid'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(usereditpost));
      debugPrint('statuscode:${response.statusCode}');
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return 'Post edited Successfully';
      } else if (response.statusCode == 500) {
        return 'Internal Server Error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //likepost
  static Future<String> postlike({required String postId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client
          .patch(Uri.parse('$baseurl$postlikeurl/$postId'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint('statuscoe:${response.statusCode}');
      if (response.statusCode == 200) {
        return 'post liked successfully';
      } else if (response.statusCode == 500) {
        return 'internal server Error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

//unlikepost
  static Future<String> postunlike({required String postId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client
          .patch(Uri.parse('$baseurl$postunlikeurl/$postId'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint('statuscode:${response.statusCode}');
      if (response.statusCode == 200) {
        return 'post unliked successfully';
      } else if (response.statusCode == 500) {
        return 'internal server error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  // fetchcomment post
  static Future fetchcomments({required String postid}) async {
    var client = http.Client();

    try {
      final token = await getUserToken();
      var response = await client
          .get(Uri.parse('$baseurl$fetchcommentsurl/$postid'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint('statuscode:${response.statusCode}');
      debugPrint(response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //add comment
  static Future<String> addcomments(
      {required String userId,
      required String userName,
      required String postId,
      required String content}) async {
    var client = http.Client();
    try {
      // final userId = await getUserId();
      final token = await getUserToken();
      final commentData = {
        'userId': userId,
        'userName': userName,
        'postId': postId,
        'content': content
      };

      var response = await client.post(
          Uri.parse('$baseurl$addcommenturl/$postId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(commentData));
      debugPrint('statuscode:${response.statusCode}');
      if (response.statusCode == 200) {
        return 'comment added successfully';
      } else if (response.statusCode == 500) {
        return 'internalserver error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //deletecomment
  static Future<String> deletecomment({required String commentid}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client
          .delete(Uri.parse('$baseurl$deletecommenturl/$commentid'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint('statuscode:${response.statusCode}');
      if (response.statusCode == 200) {
        return 'comment deleted successfully';
      } else if (response.statusCode == 500) {
        return 'internal server error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

//save post
  static Future<String> savepost({required String postId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client
          .post(Uri.parse('$baseurl$saveposturl/$postId'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint('statuscode:${response.statusCode}');
      if (response.statusCode == 200) {
        return 'data saved successfully';
      } else if (response.statusCode == 500) {
        return 'internal server error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //unsaved post
  static Future<String> unsavepost({required String postId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client
          .delete(Uri.parse('$baseurl$unsaveposturl/$postId'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint('statuscode:${response.statusCode}');
      if (response.statusCode == 200) {
        return 'post unsaved Successfully';
      } else if (response.statusCode == 500) {
        return 'internal server error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //report post
  static Future<String> reportpost(
      {required String postId, required String reportType}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      final reporterId = await getUserId();
      final reporterUsername = await getUsername();
      final reportdata = {
        'reporterId': reporterId,
        'reporterUsername': reporterUsername,
        'reportType': reportType,
        'targetId': postId
      };
      var response = await client.post(
          Uri.parse('$baseurl$reportposturl/$postId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(reportdata));
      debugPrint('statuscode:${response.statusCode}');
      if (response.statusCode == 200) {
        return 'post reported Successfully';
      } else if (response.statusCode == 500) {
        return 'Internal Server error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //fetchsavedpost
  static Future fetchsavedpost() async {
    var client = http.Client();
    final token = await getUserToken();
    try {
      var respose = await client.get(Uri.parse('$baseurl$savedposturl'),
          headers: {
            'content_Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint('statuscode:${respose.statusCode}');
      return respose;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //suggession
  static Future fetchsuggestion() async {
    var client = http.Client();
    final token = await getUserToken();
    try {
      var response = await client.get(Uri.parse('$baseurl$suggessionurl'),
          headers: {
            'content_Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint('statuscode:${response.statusCode}');
      return response;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //followpost
  static Future<String> followuser({required String followeeId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client
          .post(Uri.parse('$baseurl$followuserurl/$followeeId'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint('statuscode:${response.statusCode}');
      if (response.statusCode == 200) {
        return 'followed Successfully';
      } else if (response.statusCode == 500) {
        return 'internal server error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //unfollow user
  static Future<String> unfollowuser({required String unfolloweeId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      debugPrint('unfolloweeid:$unfolloweeId');
      var response = await client
          .put(Uri.parse('$baseurl$unfollowuserurl/$unfolloweeId'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint('statuscodeunfollow:${response.statusCode}');
      if (response.statusCode == 200) {
        return 'unfollowed Successfully';
      } else if (response.statusCode == 500) {
        return 'internal server error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //isfollowing
  static Future isfollowing({required String userId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client
          .get(Uri.parse('$baseurl$isfollowingurl/$userId'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint('statuscode:${response.statusCode}');
      return response;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //fetchfollowers
  static Future fetchfollowers() async {
    var client = http.Client();
    final token = await getUserToken();
    try {
      var respose = await client.get(Uri.parse('$baseurl$fetchfollowersurl'),
          headers: {
            'content_Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint('statuscode:${respose.statusCode}');
      return respose;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

//fetchfollowing
  static Future fetchfollowing() async {
    var client = http.Client();
    final token = await getUserToken();
    try {
      var respose = await client.get(Uri.parse('$baseurl$fetchfollowingurl'),
          headers: {
            'content_Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint('statuscode:${respose.statusCode}');
      return respose;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

//fetchexplorepost
  static Future fetchexplorepost() async {
    var client = http.Client();
    final token = await getUserToken();
    try {
      var respose = await client.get(Uri.parse('$baseurl$exploreposturl'),
          headers: {
            'content_Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint('statuscode:${respose.statusCode}');
      return respose;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //searchusers
  static Future searchusers({required String searchquery}) async {
    var client = http.Client();
    final token = await getUserToken();
    try {
      var respose = await client
          .get(Uri.parse('$baseurl$searchusersurl$searchquery'), headers: {
        'content_Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      debugPrint('statuscode:${respose.statusCode}');
      return respose;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }
}
