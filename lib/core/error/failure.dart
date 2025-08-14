import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [];
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}
