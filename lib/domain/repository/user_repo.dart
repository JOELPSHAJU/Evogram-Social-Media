import 'dart:convert';
import 'dart:developer';

import 'package:evogram/application/core/functions.dart';
import 'package:evogram/application/core/sharedpreferences.dart';
import 'package:evogram/application/core/urls.dart';
import 'package:evogram/presentation/screens/widgets/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginUserRepo {
  static var client = http.Client();

  static Future fetchloginuser() async {
    var client = http.Client();
    final token = await getUserToken();

    try {
      var response = await client.get(Uri.parse('$baseurl$loginuserurl'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint('statuscodeloginuser:${response.body}');
      return response;
    } catch (e) {
      return null;
    }
  }

  //editprofile
  static Future<Response?> editProfile(
      {required image,
      String? name,
      String? bio,
      String? imageUrl,
      String? bgImageUrl,
      required bgImage}) async {
    var client = http.Client();
    try {
      dynamic cloudinaryimageUrl;
      dynamic cloudinarybgimageUrl;
      if (imageUrl == '') {
        cloudinaryimageUrl = await uploadImage(image);
      }
      if (bgImageUrl == '') {
        cloudinarybgimageUrl = await uploadImage(bgImage);
      }
      final token = await getUsertoken();
      final details = {
        "name": name ?? '',
        "bio": bio ?? '',
        "image": imageUrl == '' ? cloudinaryimageUrl : imageUrl,
        "backGroundImage": bgImageUrl == '' ? cloudinarybgimageUrl : bgImageUrl
      };
      var response = await client.put(Uri.parse('$baseurl$editprofileurl'),
          body: jsonEncode(details),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  //get singleuser
  static Future getsingleuser({required String userId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client.get(
        Uri.parse('$baseurl$getSingleuserurl/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());

      return 'failed';
    }
  }

  //getfollowers count
  static Future getconnectioncount({required String userId}) async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client.get(
        Uri.parse('$baseurl$connectioncounturl/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());

      return 'failed';
    }
  }

  //notification
  static Future getnotification() async {
    var client = http.Client();
    try {
      final token = await getUserToken();
      var response = await client.get(
        Uri.parse('$baseurl$notificationurl'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      debugPrint('notification:${response.body}');
      return response;
    } catch (e) {
      debugPrint(e.toString());

      return 'failed';
    }
  }

//fetch suggession of users
  static Future<Response?> fetchSuggessionUser() async {
    var client = http.Client();
    try {
      final token = await getUsertoken();
      var response = client.get(Uri.parse('$baseurl$suggessionurl'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

//follow user
  static Future followUser({required String followeesId}) async {
    try {
      final token = await getUsertoken();
      var response = client.post(
          Uri.parse('$baseurl$followuserurl/$followeesId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //unfollow user
  static Future unfollowUser({required String followeesId}) async {
    try {
      final token = await getUsertoken();
      var response = client.put(
          Uri.parse('$baseurl$unfollowuserurl/$followeesId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

//fetch following
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

//fetch followers
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

//get single user
  static Future getSingleUser({required String userid}) async {
    try {
      final token = await getUsertoken();
      var response = client.get(Uri.parse('$baseurl$getSingleuserurl/$userid'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
