import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  final String email, password;
  const AuthEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [];
}

class SigninEvent extends AuthEvent {
  const SigninEvent({required super.email, required super.password});
}

class SignupEvent extends AuthEvent {
  const SignupEvent({required super.email, required super.password});
}

class ResetPasswordEvent extends AuthEvent {
  const ResetPasswordEvent({required super.email, required super.password});
}
