// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:evogram/application/core/functions.dart';
import 'package:evogram/application/core/sharedpreferences.dart';
import 'package:evogram/application/core/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PostRepo {
  static var client = http.Client();

  //user post
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

  //Add post
  static Future<Response?> addPost(String description, String image) async {
    try {
      final imageUrl = await PostRepo.uploadImage(image);
      final userid = await getUserId();
      final token = await getUsertoken();
      final post = {
        'imageUrl': imageUrl,
        'description': description,
        'userId': userid
      };

      var response = await client.post(Uri.parse(baseurl + addpostUrl),
          body: jsonEncode(post),
          headers: {
            "Content-Type": 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint(response.statusCode.toString());
      return response;
    } catch (e) {
      return null;
    }
  }

  // upload to cloudinary
  static Future uploadImage(imagePath) async {
    String filePath = imagePath;
    File file = File(filePath);
    print(filePath);
    try {
      final url =
          Uri.parse('https://api.cloudinary.com/v1_1/djruiydrx/image/upload');
      print(url);
      // final file = await imagePath.file ?? imagePath;
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'jk7jrg3d'
        ..files.add(await http.MultipartFile.fromPath('file', file.path));
      final response = await request.send();
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        log(jsonMap['url']);
        return jsonMap['url'];
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //Delete Post
  static Future<Response?> deletePost(String postId) async {
    try {
      final token = await getUsertoken();
      var response = await client.delete(
          Uri.parse('$baseurl$deleteposturln/$postId'),
          headers: {'Authorization': 'Bearer $token'});
      print('$baseurl$deleteposturln/$postId');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

//get post
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

//edit post
  static Future<Response?> editpost(
      {required String? imageurl,
      required String? image,
      required String description,
      required String postid}) async {
    dynamic cloudinaryImageurl;
    var client = http.Client();
    try {
      if (image != '') {
        cloudinaryImageurl = await uploadImage(image);
      }

      final usereditpost = {
        'imageUrl': image != '' ? cloudinaryImageurl : imageurl,
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
      return response;
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return null;
    }
  }
}
