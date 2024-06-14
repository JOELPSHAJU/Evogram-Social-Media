import 'dart:convert';

import 'dart:io';

import 'package:evogram/core/sharedpreferences.dart';
import 'package:evogram/core/urls.dart';
import 'package:evogram/presentation/userprofile/edit_profile/edit_profile.dart';
import 'package:evogram/presentation/widgets/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginUserRepo {
  //
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
  static Future<Response?> editprofile(
      {required String? imageurl,
      required String? image,
      required String? backgroundImageurl,
      required String? backgroundImage,
      required String bio,
      required String name}) async {
    dynamic profileimage;
    dynamic coverimage;
    var client = http.Client();
    try {
      if (image != '') {
        profileimage = await uploadImage(image);
      }
      if (backgroundImage != '') {
        coverimage = await uploadImage(backgroundImage);
      }
      final token = await getUserToken();
      debugPrint('image:$imageurl');
      final editdata = {
        'image': image != '' ? profileimage : imageurl,
        'name': name,
        'bio': bio,
        'backGroundImage':
            backgroundImage != '' ? coverimage : backgroundImageurl
      };

      var response = await client.put(Uri.parse('$baseurl$editprofileurl'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(editdata));
      debugPrint('statuscode:${response.body}');
      return response;
    } catch (e) {
      debugPrint(e.toString());

      return null;
    }
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
}
