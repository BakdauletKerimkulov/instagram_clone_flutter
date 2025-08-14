import 'dart:ffi';

import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String postId;
  final String userId;
  final String text;
  final Long createdAt;

  const CommentEntity({
    required this.id,
    required this.postId,
    required this.userId,
    required this.text,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [];
}
