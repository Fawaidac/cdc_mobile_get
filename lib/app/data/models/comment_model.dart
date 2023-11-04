

import 'package:cdc/app/data/models/user_model.dart';

class CommentModel {
  final String id;
  final String comment;
  final String postId;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  User user;
  CommentModel({
    required this.id,
    required this.comment,
    required this.postId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      comment: json['comment'],
      postId: json['post_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: User.fromJson(json['user']),
    );
  }
}
