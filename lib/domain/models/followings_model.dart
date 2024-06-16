class FollowingModel {
    List<Following> following;
    int totalCount;

    FollowingModel({
        required this.following,
        required this.totalCount,
    });

    factory FollowingModel.fromJson(Map<String, dynamic> json) => FollowingModel(
        following: List<Following>.from(json["following"].map((x) => Following.fromJson(x))),
        totalCount: json["totalCount"],
    );

    Map<String, dynamic> toJson() => {
        "following": List<dynamic>.from(following.map((x) => x.toJson())),
        "totalCount": totalCount,
    };
}

class Following {
    String? id;
    String? userName;
    String email;
    String? password;
    String? profilePic;
    String? phone;
    bool? online;
    bool? blocked;
    bool? verified;
    DateTime createdAt;
    DateTime updatedAt;
    int? v;
    String? role;
    bool? isPrivate;
    String? bio;
    String? name;
    String? backGroundImage;

    Following({
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
        required this.isPrivate,
        this.bio,
        this.name,
        required this.backGroundImage,
    });

    factory Following.fromJson(Map<String, dynamic> json) => Following(
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
        isPrivate: json["isPrivate"],
        bio: json["bio"],
        name: json["name"],
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
        "role":role,
        "isPrivate": isPrivate,
        "bio": bio,
        "name": name,
        "backGroundImage": backGroundImage,
    };
}



