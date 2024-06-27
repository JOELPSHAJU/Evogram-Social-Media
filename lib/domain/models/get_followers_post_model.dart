import 'package:evogram/domain/models/get_followers_userid_model.dart';

class FollwersPostModel {
  DateTime editedAt;
  List<dynamic> taggedUsers;
  String? id;
  // ignore: non_constant_identifier_names
  int CommentCount;
  FollowersUserIdModel userId;
  String? image;
  String? description;
  List<FollowersUserIdModel> likes;
  bool hidden;
  bool blocked;
  List<String> tags;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool? isLiked;
  bool? isSaved;

  FollwersPostModel({
    required this.taggedUsers,
    required this.id,
    // ignore: non_constant_identifier_names
    required this.CommentCount,
    required this.userId,
    required this.editedAt,
    required this.image,
    required this.description,
    required this.likes,
    required this.hidden,
    required this.blocked,
    required this.tags,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.isLiked,
    this.isSaved,
  });

  factory FollwersPostModel.fromJson(Map<String, dynamic> json) =>
      FollwersPostModel(
        editedAt: DateTime.parse(json["edited"]),
        taggedUsers: List<dynamic>.from(json["taggedUsers"].map((x) => x)),
        id: json["_id"],
        userId: FollowersUserIdModel.fromJson(json["userId"]),
        image: json["image"],
        description: json["description"],
        likes: List<FollowersUserIdModel>.from(
            json["likes"].map((x) => FollowersUserIdModel.fromJson(x))),
        hidden: json["hidden"],
        blocked: json["blocked"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        CommentCount: json["commentCount"],
        v: json["__v"],
        isLiked: json["isLiked"],
        isSaved: json["isSaved"],
      );

  Map<String, dynamic> toJson() => {
        "taggedUsers": List<dynamic>.from(taggedUsers.map((x) => x)),
        "_id": id,
        "userId": userId.toJson(),
        "image": image,
        "edited": editedAt.toIso8601String(),
        "description": description,
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "hidden": hidden,
        "blocked": blocked,
        "commentCount": CommentCount,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "date": date.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "isLiked": isLiked,
        "isSaved": isSaved,
      };
}
