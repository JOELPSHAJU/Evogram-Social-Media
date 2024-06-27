class SuggessionUserModel {
  List<User> data;
  int total;

  SuggessionUserModel({
    required this.data,
    required this.total,
  });

  factory SuggessionUserModel.fromJson(Map<String, dynamic> json) =>
      SuggessionUserModel(
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
      };
}

class User {
  String? id;
  String? userName;
  String? email;
  String? password;
  String? profilePic;
  String? phone;
  bool online;
  bool blocked;
  bool verified;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? role;
  String? backGroundImage;
  bool isPrivate;
  String? bio;
  String? name;

  User({
    required this.id,
    required this.userName,
    required this.email,
    this.password,
    required this.profilePic,
    required this.phone,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.role,
    required this.backGroundImage,
    required this.isPrivate,
    this.bio,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profilePic"],
        phone: json["phone"],
        online: json["online"],
        blocked: json["blocked"],
        verified: json["verified"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        role: json["role"],
        backGroundImage: json["backGroundImage"],
        isPrivate: json["isPrivate"],
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "role": role,
        "backGroundImage": backGroundImage,
        "isPrivate": isPrivate,
        "bio": bio,
        "name": name,
      };
}
