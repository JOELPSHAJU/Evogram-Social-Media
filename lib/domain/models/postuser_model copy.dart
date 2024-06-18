class UserPostModel {
  String id;
  String userName;
  String email;
  String? password;
  String profilePic;
  String backGroundImage;
  String phone;
  bool online;
  bool blocked;
  bool verified;
  String role;
  bool isPrivate;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? bio;
  String? name;
  UserPostModel({
    required this.id,
    required this.userName,
    required this.email,
    this.password,
    required this.profilePic,
    required this.backGroundImage,
    required this.phone,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.bio,
    this.name,
  });

  factory UserPostModel.fromJson(Map<String, dynamic> json) => UserPostModel(
        id: json["_id"],
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profilePic"],
        backGroundImage: json["backGroundImage"],
        phone: json["phone"],
        online: json["online"],
        blocked: json["blocked"],
        verified: json["verified"],
        role: json["role"],
        isPrivate: json["isPrivate"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        bio: json["bio"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
        "email": email,
        "password": password,
        "profilePic": profilePic,
        "backGroundImage": backGroundImage,
        "phone": phone,
        "online": online,
        "blocked": blocked,
        "verified": verified,
        "role": role,
        "isPrivate": isPrivate,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "bio": bio,
        "name": name,
      };
}
