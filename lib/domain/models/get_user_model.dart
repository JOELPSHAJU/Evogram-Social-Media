class GetUserModel {
  String userName;
  String? name;
  String id;
  String email;
  String? bio;
  bool isPrivate;
  String profilePic;
  String phone;
  bool online;
  bool access;
  // bool following;

  GetUserModel({
    required this.userName,
     this.name,
    required this.id,
    required this.email,
     this.bio,
    required this.isPrivate,
    required this.profilePic,
    required this.phone,
    required this.online,
    required this.access,
    // required this.following,
  });

  factory GetUserModel.fromJson(Map<String, dynamic> json) => GetUserModel(
        userName: json["userName"],
        name: json["name"],
        id: json["_id"],
        email: json["email"],
        bio: json["bio"],
        isPrivate: json["isPrivate"],
        profilePic: json["profilePic"],
        phone: json["phone"],
        online: json["online"],
        access: json["access"],
        // following: json["following"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "name": name,
        "_id": id,
        "email": email,
        "bio": bio,
        "isPrivate": isPrivate,
        "profilePic": profilePic,
        "phone": phone,
        "online": online,
        "access": access,
        // "following": following,
      };
}
