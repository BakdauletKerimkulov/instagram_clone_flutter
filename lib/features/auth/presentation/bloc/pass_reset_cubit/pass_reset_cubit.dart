import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_app/features/auth/domain/usecases/send_pass_reset_email.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/pass_reset_cubit/pass_reset_state.dart';

class PassResetCubit extends Cubit<PassResetState> {
  final SendPassResetEmail sendPassResetEmail;

  PassResetCubit(this.sendPassResetEmail) : super(PassResetInitial());

  Future<void> sendPassword(String email) async {
    emit(PassResetLoading());

    final result = await sendPassResetEmail(email);
    result.fold(
      (failure) => emit(PassResetError(failure.message)),
      (_) => emit(PassResetSent()),
    );
  }
}
