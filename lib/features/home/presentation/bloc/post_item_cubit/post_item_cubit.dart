import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_app/features/home/presentation/bloc/post_item_cubit/post_item_state.dart';

class PostItemCubit extends Cubit<PostItemState> {
  PostItemCubit({required bool isLiked, required bool isSaved})
    : super(PostItemState(isLiked: isLiked, isSaved: isSaved));

  void toggleLike() => emit(state.copyWith(isLiked: !state.isLiked));
  void toggleSave() => emit(state.copyWith(isSaved: !state.isSaved));
}
