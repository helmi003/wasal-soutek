class UserModel {
  final String id;
  final String displayName;
  final String image;

  UserModel({
    required this.id,
    required this.displayName,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      displayName: json['displayName'] ?? '',
      image: json['image'] ?? '',
    );
  }
}