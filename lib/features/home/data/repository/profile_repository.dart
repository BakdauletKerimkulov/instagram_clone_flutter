import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_app/core/entities/user_entity.dart';
import 'package:instagram_clone_app/core/error/exception.dart';
import 'package:instagram_clone_app/core/error/failure.dart';
import 'package:instagram_clone_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:instagram_clone_app/features/home/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final AuthDataSource authDataSource;

  ProfileRepositoryImpl(this.authDataSource);

  @override
  UserEntity? getCurrentUser() {
    final User? user = authDataSource.getCurrentUser();
    if (user != null) {
      return UserEntity(uid: user.uid, username: user.displayName);
    }
    return null;
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      print('signout method in ProfileRepository has been called');
      authDataSource.signOut();
      return Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    }
  }
}
