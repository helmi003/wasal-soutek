// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:chihebapp2/models/htppExceptionExample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  final url = dotenv.env['API_URL'];
  String get geToken => token;
  Map<String, dynamic> user = {};
  String token = "";

  Future<void> login() async {
    try {
      final response = await http.get(Uri.parse("$url/user/auth/facebook"));
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        token = body['token'];
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("token", token);
        user = JwtDecoder.decode(token);
        pref.setString("user", json.encode(user['user']));
        print(user['user']);
        notifyListeners();
      } else {
        throw HttpException2(body['message']);
      }
    } catch (exception) {
      print(exception.toString());
      throw HttpException2(exception.toString());
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      user = json.decode(prefs.getString('user').toString())
          as Map<String, dynamic>;
      token = prefs.getString('token')!;
      int expiration = user['exp'];
      bool isTokenExpired = DateTime.now()
          .isAfter(DateTime.fromMillisecondsSinceEpoch(expiration * 1000));
      if (isTokenExpired) {
        throw HttpException2("Votre session est expirée");
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
