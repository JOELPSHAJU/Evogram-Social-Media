class AllMessagesModel {
  String id;
  String senderId;
  String recieverId;
  String conversationId;
  String text;
  bool isRead;
  String deleteType;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  AllMessagesModel({
    required this.id,
    required this.senderId,
    required this.recieverId,
    required this.conversationId,
    required this.text,
    required this.isRead,
    required this.deleteType,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AllMessagesModel.fromJson(Map<String, dynamic> json) =>
      AllMessagesModel(
        id: json["_id"],
        senderId: json["senderId"],
        recieverId: json["recieverId"],
        conversationId: json["conversationId"],
        text: json["text"],
        isRead: json["isRead"],
        deleteType: json["deleteType"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "senderId": senderId,
        "recieverId": recieverId,
        "conversationId": conversationId,
        "text": text,
        "isRead": isRead,
        "deleteType": deleteType,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}