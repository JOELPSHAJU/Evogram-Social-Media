import 'dart:developer';

import 'package:evogram/application/core/functions.dart';
import 'package:evogram/application/core/urls.dart';
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
}
