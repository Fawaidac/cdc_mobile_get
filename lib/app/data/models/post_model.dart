import 'package:cdc/app/data/models/comment_model.dart';
import 'package:cdc/app/data/models/user_model.dart';

class PostAllModel {
  final String id;
  final String userId;
  final String linkApply;
  final String image;
  final String description;
  final String company;
  final String position;
  final String expired;
  final String postAt;
  final int canComment;
  final String verified;
  final List<CommentModel> comments;
  final String typeJobs;
  final User uploader;

  PostAllModel({
    required this.id,
    required this.userId,
    required this.linkApply,
    required this.image,
    required this.description,
    required this.company,
    required this.position,
    required this.expired,
    required this.postAt,
    required this.canComment,
    required this.verified,
    required this.comments,
    required this.typeJobs,
    required this.uploader,
  });

  factory PostAllModel.fromJson(Map<String, dynamic> json) {
    final List<CommentModel> comments = (json['comments'] as List)
        .map((commentJson) => CommentModel.fromJson(commentJson))
        .toList();

    return PostAllModel(
      id: json['id'],
      userId: json['user_id'],
      linkApply: json['link_apply'],
      image: json['image'],
      description: json['description'],
      company: json['company'],
      position: json['position'],
      expired: json['expired'],
      postAt: json['post_at'],
      canComment: json['can_comment'],
      verified: json['verified'],
      comments: comments,
      typeJobs: json['type_jobs'],
      uploader: User.fromJson(json['uploader']),
    );
  }
}
