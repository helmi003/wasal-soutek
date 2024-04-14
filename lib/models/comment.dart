import 'package:chihebapp2/models/userModel.dart';

class CommentModel {
  final String id;
  bool show;
  final String message;
  final UserModel user;
  final String createdAt;

  CommentModel({
    required this.id,
    required this.show,
    required this.user,
    required this.message,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'] ?? '',
      show: json['show'] ?? false,
      user: UserModel.fromJson(json['user'] ?? {}),
      message: json['message'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
