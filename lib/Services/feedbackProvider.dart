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
  List<FeedbackModel> pendingFeedbacks = [];

  Future<void> addFeedback(String name, String link, String message,
      List<XFile> photos, bool review) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final List<File> imageFiles =
          photos.map((photo) => File(photo.path)).toList();
      final request = http.MultipartRequest('POST', Uri.parse('$url/review'));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['name'] = name;
      request.fields['link'] = link;
      request.fields['message'] = message;
      request.fields['review'] = review.toString();

      for (int i = 0; i < imageFiles.length; i++) {
        request.files.add(
            await http.MultipartFile.fromPath('images', imageFiles[i].path));
      }

      final response = await request.send();
      final body = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<List<FeedbackModel>> getGoodFeedbacks(int page) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final response =
          await http.get(Uri.parse("$url/review/good/$page"), headers: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $token",
      });
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        final newFeedbacks =
            (body as List).map((json) => FeedbackModel.fromJson(json)).toList();
        if (page == 1) {
          goodFeedbacks = newFeedbacks;
        } else {
          goodFeedbacks.addAll(newFeedbacks);
        }
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

  Future<List<FeedbackModel>> getBadFeedbacks(int page) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final response =
          await http.get(Uri.parse("$url/review/bad/$page"), headers: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $token",
      });
      final body = json.decode(response.body);
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

  Future<List<FeedbackModel>> getNonApprovedFeedbacks(int page) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final response =
          await http.get(Uri.parse("$url/review/list/$page"), headers: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $token",
      });
      final body = json.decode(response.body);
      if (response.statusCode == 200) {
        pendingFeedbacks =
            (body as List).map((json) => FeedbackModel.fromJson(json)).toList();
        notifyListeners();
        return pendingFeedbacks;
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

  Future<bool> deleteFeedback(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final response =
          await http.delete(Uri.parse("$url/review/$id"), headers: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $token",
      });
      final body = json.decode(response.body);
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

  Future<bool> approveFeedback(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
      final response =
          await http.put(Uri.parse("$url/review/approve/$id"), headers: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $token",
      });
      final body = json.decode(response.body);
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

  updateGoodFeedbacks(List<FeedbackModel> feedbacks) {
    goodFeedbacks = feedbacks;
  }

  updateBadFeedbacks(List<FeedbackModel> feedbacks) {
    badFeedbacks = feedbacks;
  }

  void removeGoodFeedback(String id) {
    final index = goodFeedbacks.indexWhere((f) => f.id == id);
    if (index != -1) {
      goodFeedbacks.removeAt(index);
      notifyListeners();
    }
  }

  void removeBadFeedback(String id) {
    final index = badFeedbacks.indexWhere((f) => f.id == id);
    if (index != -1) {
      badFeedbacks.removeAt(index);
      notifyListeners();
    }
  }
}
