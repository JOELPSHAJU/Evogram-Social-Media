class LoginUserModel {
  final String id;
  final String userName;
  final String email;
  final String phone;
  final bool online;
  final bool blocked;
  final bool verified;
  final String role;
  final bool isPrivate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? bio;
  final String? name;
  final String profilePic;
  final String backGroundImage;

 LoginUserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phone,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.createdAt,
    required this.updatedAt,
     this.bio,
    this.name,
    required this.profilePic,
    required this.backGroundImage,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      phone: json['phone'],
      online: json['online'],
      blocked: json['blocked'],
      verified: json['verified'],
      role: json['role'],
      isPrivate: json['isPrivate'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      bio: json['bio'],
      name: json['name'],
      profilePic: json['profilePic'],
      backGroundImage: json['backGroundImage'],
    );
  }
}

