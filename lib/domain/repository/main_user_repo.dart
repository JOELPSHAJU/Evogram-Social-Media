import 'dart:developer';

import 'package:evogram/application/core/functions.dart';
import 'package:evogram/application/core/sharedpreferences.dart';
import 'package:evogram/application/core/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserRepo {
  static var client = http.Client();

  //search users
  static Future searchAllUsers({required String query}) async {
    try {
      final token = await getUsertoken();
      var response = await client.get(
          Uri.parse('$baseurl}$searchAllUsersurl$query'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

//get connections
  static Future getConnections({required String userId}) async {
    try {
      final token = await getUsertoken();
      var response = client.get(Uri.parse('$baseurl$getConnectionsurl/$userId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //Fetch loggedIn user details
  static Future fetchLoggedInUserDetails() async {
    try {
      final token = await getUsertoken();
      var response = await client.get(Uri.parse('$baseurl$logginedUser'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //Fetch loggedIn user posts
  static Future fetchUserPosts({String? userId}) async {
    try {
      final loggineduserId = await getUserId();
      var response = await client.get(Uri.parse(
          '$baseurl$getPostByUserId/${userId == '' ? loggineduserId : userId}'));
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //Fetch loggedIn user posts Explore page
  static Future fetchUserPostsExplore({required String userId}) async {
    try {
      var response =
          await client.get(Uri.parse('$baseurl$getPostByUserId/$userId'));
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
