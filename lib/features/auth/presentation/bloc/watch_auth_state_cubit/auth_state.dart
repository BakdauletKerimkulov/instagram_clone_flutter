import 'package:equatable/equatable.dart';
import 'package:instagram_clone_app/core/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity user;
  const Authenticated(this.user);
}

class AuthInitial extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}
