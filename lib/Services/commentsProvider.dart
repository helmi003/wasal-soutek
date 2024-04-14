// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:chihebapp2/models/comment.dart';
import 'package:chihebapp2/models/htppExceptionExample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CommentProvider with ChangeNotifier {
  final url = dotenv.env['API_URL'];
  String token = "";
  List<CommentModel> comments = [];

  Future<void> addComment(String id, String message) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final response = await http.post(Uri.parse("$url/comment/$id"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "Bearer $token",
          },
          body: json.encode({"message": message}));
      final body = json.decode(response.body);
      print(body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        notifyListeners();
      } else {
        throw HttpException2(body);
      }
    } on SocketException {
      throw HttpException2("Impossible d'accéder à Internet!");
    } catch (exception) {
      throw HttpException2(exception.toString());
    }
  }

  Future<bool> deleteComment(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final response =
          await http.delete(Uri.parse("$url/comment/$id"), headers: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $token",
      });
      final body = json.decode(response.body);
      print(body);
      if (response.statusCode == 200) {
        notifyListeners();
        return true;
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

  Future<List<CommentModel>> getComments(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final response = await http.get(Uri.parse("$url/comment/$id"), headers: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $token",
      });
      final body = json.decode(response.body);
      print(body);
      if (response.statusCode == 200) {
        comments =
            (body as List).map((json) => CommentModel.fromJson(json)).toList();
        notifyListeners();
        return comments;
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

  void toggleShow(CommentModel comment) {
    final index = comments.indexWhere((c) => c.id == comment.id);
    if (index != -1) {
      comments[index].show = !comments[index].show;
    }
  }
}
