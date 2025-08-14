import 'package:dartz/dartz.dart';
import 'package:instagram_clone_app/core/entities/user_entity.dart';
import 'package:instagram_clone_app/core/error/exception.dart';
import 'package:instagram_clone_app/core/error/failure.dart';
import 'package:instagram_clone_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:instagram_clone_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  UserEntity? getCurrentUser() {
    final user = authDataSource.getCurrentUser();
    if (user != null) {
      return UserEntity(uid: user.uid, username: user.displayName);
    }
    return null;
  }

  @override
  bool isUserLoggedIn() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity?>> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final firebaseUser = await authDataSource.signInWithEmail(
        email,
        password,
      );
      if (firebaseUser != null) {
        return Right(
          UserEntity(uid: firebaseUser.uid, username: firebaseUser.displayName),
        );
      }
      return Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      authDataSource.signOut();
      return Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> signUpWithEmail(
    String email,
    String password,
  ) async {
    try {
      final firebaseUser = await authDataSource.signUpWithEmail(
        email,
        password,
      );
      if (firebaseUser != null) {
        return Right(UserEntity(uid: firebaseUser.uid));
      }

      return Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    }
  }

  @override
  Stream<UserEntity?> watchAuthState() {
    return authDataSource.watchAuthState().map(
      (user) => user != null ? UserEntity(uid: user.uid) : null,
    );
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      return Right(await authDataSource.sendPasswordResetEmail(email));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    }
  }
}
