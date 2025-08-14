import 'package:equatable/equatable.dart';

class PostItemState extends Equatable {
  final bool isLiked;
  final bool isSaved;

  const PostItemState({required this.isLiked, required this.isSaved});

  PostItemState copyWith({bool? isLiked, bool? isSaved}) {
    return PostItemState(
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [];
}
