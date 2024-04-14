// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:chihebapp2/models/feedbackModel.dart';
import 'package:chihebapp2/models/htppExceptionExample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackProvider with ChangeNotifier {
  final url = dotenv.env['API_URL'];
  String token = "";
  List<FeedbackModel> badFeedbacks = [];
  List<FeedbackModel> goodFeedbacks = [];

  Future<void> addFeedback(
      String name,String link,String message, List<XFile> photos, bool review) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final List<File> imageFiles = photos.map((photo) => File(photo.path)).toList();
      final response = await http.post(Uri.parse("$url/review"),
          headers: {
            "Content-Type": "multipart/form-data",
            'Authorization': "Bearer $token",
          },
          body: json.encode({
            "name": name,
            "link": link,
            "message": message,
            "images": imageFiles.map((file) => file.path).toList(),
            "review": review,
          }));

      final body = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<List<FeedbackModel>> getGoodFeedbacks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final response = await http.get(Uri.parse("$url/review/good"), headers: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $token",
      });
      final body = json.decode(response.body);
      print(body);
      if (response.statusCode == 200) {
        goodFeedbacks =
            (body as List).map((json) => FeedbackModel.fromJson(json)).toList();
        notifyListeners();
        return goodFeedbacks;
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

  Future<List<FeedbackModel>> getBadFeedbacks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final response = await http.get(Uri.parse("$url/review/bad"), headers: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $token",
      });
      final body = json.decode(response.body);
      print(body);
      if (response.statusCode == 200) {
        badFeedbacks =
            (body as List).map((json) => FeedbackModel.fromJson(json)).toList();
        notifyListeners();
        return badFeedbacks;
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
}
