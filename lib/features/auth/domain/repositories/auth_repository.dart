import 'package:dartz/dartz.dart';
import 'package:instagram_clone_app/core/entities/user_entity.dart';
import 'package:instagram_clone_app/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity?>> signUpWithEmail(
    String email,
    String password,
  );
  Future<Either<Failure, UserEntity?>> signInWithEmail(
    String email,
    String password,
  );

  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  bool isUserLoggedIn();
  UserEntity? getCurrentUser();

  Stream<UserEntity?> watchAuthState();

  Future<Either<Failure, void>> signOut();
}
