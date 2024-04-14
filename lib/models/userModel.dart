class UserModel {
  final String id;
  final String displayName;
  final String photo;

  UserModel({
    required this.id,
    required this.displayName,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      displayName: json['displayName'] ?? '',
      photo: json['photo'] ?? '',
    );
  }
}