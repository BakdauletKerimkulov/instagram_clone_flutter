import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String uid;
  final String userUid;
  final PostType type;
  final String contentUrl;
  final DateTime createdAt;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final bool isSaved;

  const PostEntity({
    required this.uid,
    required this.userUid,
    required this.type,
    required this.contentUrl,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.isSaved,
  });

  @override
  List<Object?> get props => [
    uid,
    userUid,
    type,
    contentUrl,
    createdAt,
    likeCount,
    commentCount,
  ];
}

enum PostType { image, video, carousel }
