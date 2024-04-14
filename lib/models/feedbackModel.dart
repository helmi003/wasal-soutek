import 'package:chihebapp2/models/userModel.dart';

class FeedbackModel {
  final String id;
  final String name;
  final String link;
  final List images;
  final bool review;
  final UserModel user;
  final String message;
  final bool approved;
  final String createdAt;

  FeedbackModel({
    required this.id,
    required this.name,
    required this.link,
    required this.images,
    required this.review,
    required this.user,
    required this.message,
    required this.approved,
    required this.createdAt,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      link: json['link'] ?? '',
      images: json['images'] ?? [],
      review: json['review'] ?? false,
      user: UserModel.fromJson(json['user'] ?? {}),
      message: json['message'] ?? '',
      approved: json['approved'] ?? false,
      createdAt: json['createdAt'] ?? '',
    );
  }
}