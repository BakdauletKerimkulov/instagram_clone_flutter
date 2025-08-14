import 'package:dartz/dartz.dart';
import 'package:instagram_clone_app/core/error/failure.dart';
import 'package:instagram_clone_app/features/home/domain/repository/profile_repository.dart';

class Signout {
  final ProfileRepository profileRepository;

  Signout(this.profileRepository);

  Future<Either<Failure, void>> call() async {
    print('signout usecase has been called');
    return await profileRepository.signOut();
  }
}
