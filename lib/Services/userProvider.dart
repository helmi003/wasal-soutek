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

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$url/user/login"),
        body: {"email": email, "password": password},
      );
      final body = json.decode(response.body);
      if (response.statusCode == 201) {
        token = body['token'];
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("token", token);
        user = JwtDecoder.decode(token);
        pref.setString("user", json.encode(user));
        notifyListeners();
      } else {
        throw HttpException2(body['message']);
      }
    } on SocketException {
      throw HttpException2("Impossible d'accéder à Internet!");
    } on FormatException {
      throw HttpException2("Une erreur est survenue");
    } on StateError {
      throw HttpException2("Une erreur est survenue");
    } catch (exception) {
      throw HttpException2(exception.toString());
    }
  }

  Future<void> register(
      String displayName, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$url/user/register"),
        body: {
          "email": email,
          "password": password,
          "displayName": displayName
        },
      );
      final body = json.decode(response.body);
      if (response.statusCode == 201) {
        notifyListeners();
      } else {
        throw HttpException2(body['message']);
      }
    } on SocketException {
      throw HttpException2("Impossible d'accéder à Internet!");
    } on FormatException {
      throw HttpException2("Une erreur est survenue");
    } on StateError {
      throw HttpException2("Une erreur est survenue");
    } catch (exception) {
      throw HttpException2(exception.toString());
    }
  }

  // Future<void> login(String email,String password) async {
  //   try {
  //     final response = await http.get(Uri.parse("$url/user/auth/login"));
  //     final body = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       // token = body['token'];
  //       // SharedPreferences pref = await SharedPreferences.getInstance();
  //       // pref.setString("token", token);
  //       // user = JwtDecoder.decode(token);
  //       // pref.setString("user", json.encode(user['user']));
  //       print(user);
  //       notifyListeners();
  //     } else {
  //       throw HttpException2(body['message']);
  //     }
  //   } catch (exception) {
  //     print(exception.toString());
  //     throw HttpException2(exception.toString());
  //   }
  // }

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

  Future<void> updateProfile(String displayName, File? photo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final request =
          http.MultipartRequest('PUT', Uri.parse('$url/user'));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['displayName'] = displayName;
      if (photo != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', photo.path));
      }
      final response = await request.send();
      final body = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("user", json.encode(body));
        user = json.decode(body);
        notifyListeners();
      } else {
        throw HttpException2(body);
      }
    } on SocketException {
      throw HttpException2("Impossible d'accéder à Internet!");
    } on FormatException {
      throw HttpException2("Une erreur est survenue");
    } on StateError {
      throw HttpException2("Une erreur est survenue");
    } catch (exception) {
      throw HttpException2(exception.toString());
    }
  }
}
