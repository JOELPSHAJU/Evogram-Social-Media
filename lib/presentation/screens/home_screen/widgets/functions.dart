import 'package:evogram/application/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getUsertoken() async {
  final sharedpreference = await SharedPreferences.getInstance();
  final token = sharedpreference.getString(tokenKey);
  return token;
}

//get Userid
Future<String?> getUserId() async {
  final sharedpreference = await SharedPreferences.getInstance();
  final userId = sharedpreference.getString(userIdKey);
  return userId;
}