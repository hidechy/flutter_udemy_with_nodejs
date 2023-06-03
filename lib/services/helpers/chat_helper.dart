// ignore_for_file: depend_on_referenced_packages, avoid_classes_with_only_static_members

import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/chat/create_chat.dart';
import '../../models/response/chat/get_chat.dart';
import '../../models/response/chat/intitial_msg.dart';
import '../config.dart';

class ChatHelper {
  static https.Client client = https.Client();

  // Apply for job
  static Future<List<dynamic>> apply(CreateChat model) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    final url = Uri.https(Config.apiUrl, Config.chatsUrl);
    final response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    if (response.statusCode == 200) {
      final first = initialChatFromJson(response.body).id;

      return [true, first];
    } else {
      return [false];
    }
  }

  static Future<List<GetChats>> getConversations() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    final url = Uri.https(Config.apiUrl, Config.chatsUrl);
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final chats = getChatsFromJson(response.body);

      return chats;
    } else {
      throw Exception("Couldn't load chats");
    }
  }
}
