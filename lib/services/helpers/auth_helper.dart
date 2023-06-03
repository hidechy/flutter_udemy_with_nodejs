// ignore_for_file: depend_on_referenced_packages, avoid_classes_with_only_static_members

import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/auth/login_model.dart';
import '../../models/request/auth/profile_update_model.dart';
import '../../models/request/auth/signup_model.dart';
import '../../models/response/auth/login_res_model.dart';
import '../../models/response/auth/profile_model.dart';
import '../config.dart';

class AuthHelper {
  static https.Client client = https.Client();

  static Future<bool> login(LoginModel model) async {
    final requestHeaders = <String, String>{'Content-Type': 'application/json'};

    final url = Uri.https(Config.apiUrl, Config.loginUrl);
    final response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();

      final token = loginResponseModelFromJson(response.body).userToken;
      final userId = loginResponseModelFromJson(response.body).id;
      final profile = loginResponseModelFromJson(response.body).profile;

      await prefs.setString('token', token);
      await prefs.setString('userId', userId);
      await prefs.setString('profile', profile);
      await prefs.setBool('loggedIn', true);

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> signup(SignupModel model) async {
    final requestHeaders = <String, String>{'Content-Type': 'application/json'};

    final url = Uri.https(Config.apiUrl, Config.signupUrl);
    final response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateProfile(ProfileUpdateReq model) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    final url = Uri.https(Config.apiUrl, Config.profileUrl);
    final response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<ProfileRes> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    final url = Uri.https(Config.apiUrl, Config.profileUrl);
    final response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final profile = profileResFromJson(response.body);
      return profile;
    } else {
      throw Exception('Failed to get the profile');
    }
  }
}
