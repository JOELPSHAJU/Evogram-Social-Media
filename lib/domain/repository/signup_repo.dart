// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:convert';
import 'dart:developer';

import 'package:evogram/domain/models/signup_model.dart';
import 'package:evogram/application/core/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class SignupRepo {
  static var client = http.Client();
  static Future<String> signupuser({required UserModel user}) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('$baseurl$signup'),
          body: jsonEncode(user),
          headers: {'Content-Type': 'application/json'});
      debugPrint('statuscode:${response.statusCode}');
      debugPrint(response.body);
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return 'Successful';
      } else if (responseBody['message'] == "You already have an account.") {
        return 'You already have an account';
      } else if (responseBody['message'] ==
          "OTP already sent within the last one minute") {
        return 'OTP already sent within the last one minute';
      } else if (responseBody['message'] == "The username is already taken.") {
        return 'The username is already taken.';
      } else if (response.statusCode == 500) {
        return 'Internal server Error';
      } else {
        return ' failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //otp
  static Future<String> verifyOtp(
      {required String email, required String oteepee}) async {
    var client = http.Client();
    try {
      final user = {'email': email, 'otp': oteepee};

      var response = await client.post(
        Uri.parse('$baseurl$otpurl'),
        body: user,
      );
      debugPrint('statuscode:${response.statusCode}');
      debugPrint(response.body);
      final responsebody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return 'successful';
      } else if (responsebody['message'] ==
          'Invalid verification code or OTP expired') {
        return 'Invalid verification code or OTP expired';
      } else if (response.statusCode == 500) {
        return 'Internal server error';
      } else {
        return 'failed';
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return 'failed';
    }
  }

  //signin
  static Future<Response?> userlogin(
      {required String email, required String password}) async {
    var client = http.Client();
    try {
      final loginuser = {'email': email, 'password': password};
      var response =
          await client.post(Uri.parse('$baseurl$loginurl'), body: loginuser);
      debugPrint('statuscode:${response.statusCode}');
      debugPrint(response.body);
      final responsebody = jsonDecode(response.body);
      // print(responsebody['message']);
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('LOGIN', true);
        preferences.setString('USER_TOKEN', responsebody['user']['token']);
        preferences.setString('USER_ID', responsebody['user']['_id']);
        preferences.setString('USER_NAME', responsebody['user']['userName']);
        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return null;
    }
  }

  static Future<Response?> googleLogin(String email) async {
    try {
      final finalEmail = {'email': email};
      var response = await client.post(Uri.parse(baseurl + googleLoginurl),
          body: jsonEncode(finalEmail),
          headers: {"Content-Type": 'application/json'});
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('LOGIN', true);
        preferences.setBool('LOGIN', true);
        preferences.setString('USER_TOKEN', responseBody['user']['token']);
        preferences.setString('USER_ID', responseBody['user']['_id']);
        preferences.setString('USER_NAME', responseBody['user']['userName']);
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> resetPassSendOtp(String email) async {
    try {
      Response? response =
          await client.get(Uri.parse('${baseurl + forgotPasswordurl}$email'));
      // print('${ApiEndpoints.baseUrl+ApiEndpoints.forgotPassword}$email');
      // ignore: avoid_print
      print(response.body);

      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> verifyOtpPasswordReset(
      String email, String otp) async {
    try {
      var response = await client
          .get(Uri.parse('${baseurl + verifyOtpReset}$email&otp=$otp'));
      // print(response.body);
      //  print('${ApiEndpoints.baseUrl+ApiEndpoints.verifyOtpReset}$email&otp=$otp');
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> updatePassword(String email, String password) async {
    try {
      var user = {'email': email, 'password': password};
      var response = await client.patch(Uri.parse(baseurl + updatePasswordurl),
          body: jsonEncode(user),
          headers: {"Content-Type": 'application/json'});
      print(response.body);
      return response;
    } catch (e) {
      return null;
    }
  }
}
