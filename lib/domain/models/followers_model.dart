class FollowersModel {
  List<Follower> followers;
  int totalCount;

  FollowersModel({
    required this.followers,
    required this.totalCount,
  });

  factory FollowersModel.fromJson(Map<String, dynamic> json) => FollowersModel(
        followers: List<Follower>.from(
            json["followers"].map((x) => Follower.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "followers": List<dynamic>.from(followers.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class Follower {
  String id;
  String userName;
  String email;
  String? password;
  String profilePic;
  String phone;
  bool online;
  bool blocked;
  bool verified;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String role;
  String? bio;
  String? name;
  bool isPrivate;
  String backGroundImage;

  Follower({
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
    this.bio,
    this.name,
    required this.isPrivate,
    required this.backGroundImage,
  });

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
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
        bio: json["bio"],
        name: json["name"],
        isPrivate: json["isPrivate"],
        backGroundImage: json["backGroundImage"],
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
        "bio": bio,
        "name": name,
        "isPrivate": isPrivate,
        "backGroundImage": backGroundImage,
      };
}
