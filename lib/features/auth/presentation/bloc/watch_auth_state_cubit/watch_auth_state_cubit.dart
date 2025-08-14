import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_app/core/entities/user_entity.dart';
import 'package:instagram_clone_app/features/auth/domain/usecases/watch_auth_state.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/watch_auth_state_cubit/auth_state.dart';

class WatchAuthStateCubit extends Cubit<AuthState> {
  final WatchAuthState watchAuthState;
  late StreamSubscription<UserEntity?> _authSubscription;

  WatchAuthStateCubit(this.watchAuthState) : super(AuthInitial()) {
    _authSubscription = watchAuthState().listen((user) {
      log('Auth state. User is null: ${user == null}');
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    }, onError: (e) => emit(AuthError(e.toString())));
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    log('WatchAuthStateCubit called');
    return super.close();
  }
}
