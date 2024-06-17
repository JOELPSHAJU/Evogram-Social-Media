import 'dart:convert';
import 'dart:developer';

import 'package:evogram/application/core/functions.dart';
import 'package:evogram/application/core/urls.dart';
import 'package:http/http.dart' as http;


class ChatRepo {
  static var client = http.Client();

//Create conversation
  static Future createConversation({required List<String> members}) async {
    try {
      final token = await getUsertoken();
      final body = {"members": members};
      var response = client.post(
          Uri.parse(
              '$baseurl$createConversationurl'),
          body: jsonEncode(body),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': "application/json"
          });
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

//get all conversations
  static Future getAllConversations() async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse(
              '$baseurl$getAllConversationsurl'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

//Add message
  static Future addMessage(
      {required String recieverId,
      required String text,
      required String conversationId,
      required String senderId}) async {
    try {
      final token = await getUsertoken();
      final body = {
        "senderId": senderId,
        "conversationId": conversationId,
        "text": text,
        "recieverId": recieverId
      };
      var response = client.post(
          Uri.parse('$baseurl$addMessageurl'),
          body: jsonEncode(body),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": 'application/json'
          });
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

//get all Messages
  static Future getAllMessages({required String conversationId}) async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse(
              '$baseurl$getAllMessagesurl/$conversationId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
