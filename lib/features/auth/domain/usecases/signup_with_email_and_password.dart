import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone_app/core/entities/user_entity.dart';
import 'package:instagram_clone_app/core/error/failure.dart';
import 'package:instagram_clone_app/core/usecases/usecase.dart';
import 'package:instagram_clone_app/features/auth/domain/repositories/auth_repository.dart';

class SignupWithEmailAndPassword extends Usecase<UserEntity?, AuthParams> {
  final AuthRepository authRepository;

  SignupWithEmailAndPassword(this.authRepository);

  @override
  Future<Either<Failure, UserEntity?>> call(params) async {
    return await authRepository.signUpWithEmail(params.email, params.password);
  }
}

class AuthParams extends Equatable {
  final String email, password;

  const AuthParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
