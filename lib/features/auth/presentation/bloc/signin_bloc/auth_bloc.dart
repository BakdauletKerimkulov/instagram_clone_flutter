import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_app/core/entities/user_entity.dart';
import 'package:instagram_clone_app/core/error/failure.dart';
import 'package:instagram_clone_app/features/auth/domain/usecases/signin_with_email_and_password.dart';
import 'package:instagram_clone_app/features/auth/domain/usecases/signup_with_email_and_password.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/signin_bloc/auth_event.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/signin_bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninWithEmailAndPassword signinWithEmailAndPassword;
  final SignupWithEmailAndPassword signupWithEmailAndPassword;

  AuthBloc({
    required this.signinWithEmailAndPassword,
    required this.signupWithEmailAndPassword,
  }) : super(InitialState()) {
    on<SigninEvent>(_handleSignin);
    on<SignupEvent>(_handleSignup);
  }

  Future<void> _handleSignin(SigninEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signinWithEmailAndPassword(
      AuthParams(email: event.email, password: event.password),
    );
    _emitResult(result, emit);
  }

  Future<void> _handleSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signupWithEmailAndPassword(
      AuthParams(email: event.email, password: event.password),
    );
    _emitResult(result, emit);
  }

  void _emitResult(
    Either<Failure, UserEntity?> result,
    Emitter<AuthState> emit,
  ) {
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(user != null ? Authenticated(user) : Unauthenticated()),
    );
  }
}
