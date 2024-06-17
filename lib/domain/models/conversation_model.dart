
class ConversationModel {
  String id;
  List<String> members;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? lastMessage;
  DateTime? lastMessageTime;

  ConversationModel({
    required this.id,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.lastMessage,
    this.lastMessageTime,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        id: json["_id"],
        members: List<String>.from(json["members"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        lastMessage: json["lastMessage"],
        lastMessageTime: json["lastMessageTime"] == null
            ? null
            : DateTime.parse(json["lastMessageTime"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "members": List<dynamic>.from(members.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "lastMessage": lastMessage,
        "lastMessageTime": lastMessageTime?.toIso8601String(),
      };
}
