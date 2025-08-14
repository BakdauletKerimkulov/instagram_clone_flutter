import 'package:dartz/dartz.dart';
import 'package:instagram_clone_app/core/entities/user_entity.dart';
import 'package:instagram_clone_app/core/error/failure.dart';

abstract class ProfileRepository {
  const ProfileRepository();

  UserEntity? getCurrentUser();

  Future<Either<Failure, void>> signOut();
}
