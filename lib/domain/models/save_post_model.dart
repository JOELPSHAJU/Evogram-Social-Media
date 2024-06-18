
class SavePostModel {
    String userId;
    String postId;
    String id;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    SavePostModel({
        required this.userId,
        required this.postId,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory SavePostModel.fromJson(Map<String, dynamic> json) => SavePostModel(
        userId: json["userId"],
        postId: json["postId"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "postId": postId,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
