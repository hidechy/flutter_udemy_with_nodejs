// ignore_for_file: depend_on_referenced_packages, avoid_classes_with_only_static_members

import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/bookmarks/bookmarks_model.dart';
import '../../models/response/bookmarks/all_bookmarks.dart';
import '../../models/response/bookmarks/book_res.dart';
import '../config.dart';

class BookMarkHelper {
  static https.Client client = https.Client();

// ADD BOOKMARKS
  static Future<List<dynamic>> addBookmarks(BookmarkReqResModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    final url = Uri.https(Config.apiUrl, Config.bookmarkUrl);
    final response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      final bookmarkId = bookMarkReqResFromJson(response.body).id;
      return [true, bookmarkId];
    } else {
      return [false];
    }
  }

  // DELETE BOOKMARKS
  static Future<bool> deleteBookmarks(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    final url = Uri.https(Config.apiUrl, '${Config.bookmarkUrl}/$jobId');
    final response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // DELETE BOOKMARKS
  static Future<List<AllBookmark>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    final url = Uri.https(Config.apiUrl, Config.bookmarkUrl);
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final bookmarks = allBookmarkFromJson(response.body);
      return bookmarks;
    } else {
      throw Exception('Failed to load bookmarks');
    }
  }
}
