import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_app/features/home/domain/usecases/signout.dart';
import 'package:instagram_clone_app/features/home/presentation/bloc/signout_cubit/signout_state.dart';

class SignoutCubit extends Cubit<SignoutState> {
  final Signout signout;

  SignoutCubit(this.signout) : super(InitialState());

  void signOut() async {
    emit(SignoutLoadingState());

    final result = await signout();
    result.fold(
      (failure) => emit(SignoutErrorState()),
      (_) => emit(SignoutSuccessState()),
    );
  }
}
