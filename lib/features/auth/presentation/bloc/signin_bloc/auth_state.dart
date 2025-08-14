import 'package:equatable/equatable.dart';
import 'package:instagram_clone_app/core/entities/user_entity.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class InitialState extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity userEntity;

  const Authenticated(this.userEntity);
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

class AuthLoading extends AuthState {}

class PasswordResetSent extends AuthState {}
