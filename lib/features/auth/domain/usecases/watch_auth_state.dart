import 'package:equatable/equatable.dart';
import 'package:instagram_clone_app/core/entities/user_entity.dart';
import 'package:instagram_clone_app/features/auth/domain/repositories/auth_repository.dart';

class WatchAuthState extends Equatable {
  final AuthRepository authRepository;

  const WatchAuthState(this.authRepository);

  Stream<UserEntity?> call() => authRepository.watchAuthState();

  @override
  List<Object?> get props => [];
}
