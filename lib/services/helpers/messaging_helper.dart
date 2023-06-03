// ignore_for_file: depend_on_referenced_packages, avoid_classes_with_only_static_members, prefer_final_locals

import 'dart:convert';

import 'package:http/http.dart' as https;

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/messaging/send_message.dart';
import '../../models/response/messaging/messaging_res.dart';
import '../config.dart';

class MesssagingHelper {
  static https.Client client = https.Client();

  // Apply for job
  static Future<List<dynamic>> sendMessage(SendMessage model) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    final url = Uri.https(Config.apiUrl, Config.messagingUrl);
    final response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      final message = ReceivedMessge.fromJson(jsonDecode(response.body));

      Map<String, dynamic> responseMap = jsonDecode(response.body);
      return [true, message, responseMap];
    } else {
      return [false];
    }
  }

  static Future<List<ReceivedMessge>> getMessages(
      String chatId, int offset) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    final url = Uri.https(Config.apiUrl, '${Config.messagingUrl}/$chatId',
        {'page': offset.toString()});
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final messages = receivedMessgeFromJson(response.body);

      return messages;
    } else {
      throw Exception(' failed to load messages');
    }
  }
}
