class UserIdSearchModel {
  String id;
  String userName;
  String email;
  String? password;
  String profilePic;
  String? phone;
  bool online;
  bool blocked;
  bool verified;
  String role;
  bool isPrivate;
  String backGroundImage;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? bio;
  String? name;

  UserIdSearchModel({
    required this.id,
    required this.userName,
    required this.email,
    this.password,
    required this.profilePic,
     this.phone,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.backGroundImage,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.bio,
    this.name,
  });

  factory UserIdSearchModel.fromJson(Map<String, dynamic> json) => UserIdSearchModel(
        id: json["_id"],
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profilePic"],
        phone: json["phone"],
        online: json["online"],
        blocked: json["blocked"],
        verified: json["verified"],
        role: json["role"],
        isPrivate: json["isPrivate"],
        backGroundImage: json["backGroundImage"],
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
        "phone": phone,
        "online": online,
        "blocked": blocked,
        "verified": verified,
        "role": role,
        "isPrivate": isPrivate,
        "backGroundImage": backGroundImage,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "bio": bio,
        "name": name,
      };
}
