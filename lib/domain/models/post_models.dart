import 'package:evogram/domain/models/user_id.dart';

class Postmodel {
    String id;
    UserId userId;
    String image;
    String description;
    List<dynamic> likes;
    bool hidden;
    bool blocked;
    DateTime date;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Postmodel({
        required this.id,
        required this.userId,
        required this.image,
        required this.description,
        required this.likes,
        required this.hidden,
        required this.blocked,
        required this.date,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory  Postmodel.fromJson(Map<String, dynamic> json) =>  Postmodel(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        image: json["image"],
        description: json["description"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        hidden: json["hidden"],
        blocked: json["blocked"],
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "image": image,
        "description": description,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "hidden": hidden,
        "blocked": blocked,
        "date": date.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}


