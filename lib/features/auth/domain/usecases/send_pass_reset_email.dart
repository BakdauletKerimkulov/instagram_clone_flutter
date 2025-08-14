import 'package:dartz/dartz.dart';
import 'package:instagram_clone_app/core/error/failure.dart';
import 'package:instagram_clone_app/features/auth/domain/repositories/auth_repository.dart';

class SendPassResetEmail {
  final AuthRepository authRepository;

  SendPassResetEmail(this.authRepository);

  Future<Either<Failure, void>> call(String email) {
    return authRepository.sendPasswordResetEmail(email);
  }
}
