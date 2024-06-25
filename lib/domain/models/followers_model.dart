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
  String backGroundImage;
  String id;
  String userName;
  String email;
  String password;
  String profilePic;
  String? phone;
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

  Follower({
    required this.backGroundImage,
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.profilePic,
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

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        backGroundImage: json["backGroundImage"],
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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        bio: json["bio"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "backGroundImage": backGroundImage,
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "bio": bio,
        "name": name,
      };
}
