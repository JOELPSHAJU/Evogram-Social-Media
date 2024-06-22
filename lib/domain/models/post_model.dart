import 'package:evogram/domain/models/suggession_user_model.dart';
class Post {
  final String id;
  final User userId;
  final String image;
  final String description;
  final List<String> likes;
  final bool hidden;
  final bool blocked;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Post({
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

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      userId: User.fromJson(json['userId']),
      image: json['image'],
      description: json['description'],
      likes: List<String>.from(json['likes']),
      hidden: json['hidden'],
      blocked: json['blocked'],
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId.toJson(),
      'image': image,
      'description': description,
      'likes': likes,
      'hidden': hidden,
      'blocked': blocked,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'v': v,
    };
  }
}
