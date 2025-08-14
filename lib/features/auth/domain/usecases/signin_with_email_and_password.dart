import 'package:dartz/dartz.dart';
import 'package:instagram_clone_app/core/entities/user_entity.dart';
import 'package:instagram_clone_app/core/error/failure.dart';
import 'package:instagram_clone_app/core/usecases/usecase.dart';
import 'package:instagram_clone_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:instagram_clone_app/features/auth/domain/usecases/signup_with_email_and_password.dart';

class SigninWithEmailAndPassword extends Usecase<UserEntity?, AuthParams> {
  final AuthRepository authRepository;

  SigninWithEmailAndPassword(this.authRepository);

  @override
  Future<Either<Failure, UserEntity?>> call(AuthParams params) async {
    return await authRepository.signInWithEmail(params.email, params.password);
  }
}
