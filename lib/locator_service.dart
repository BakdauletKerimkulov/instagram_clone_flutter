import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_clone_app/core/platform/network_info.dart';
import 'package:instagram_clone_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:instagram_clone_app/features/auth/data/repositories/auth_repository.dart';
import 'package:instagram_clone_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:instagram_clone_app/features/auth/domain/usecases/send_pass_reset_email.dart';
import 'package:instagram_clone_app/features/auth/domain/usecases/signin_with_email_and_password.dart';
import 'package:instagram_clone_app/features/auth/domain/usecases/signup_with_email_and_password.dart';
import 'package:instagram_clone_app/features/auth/domain/usecases/watch_auth_state.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/pass_reset_cubit/pass_reset_cubit.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/signin_bloc/auth_bloc.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/watch_auth_state_cubit/watch_auth_state_cubit.dart';
import 'package:instagram_clone_app/features/home/data/repository/profile_repository.dart';
import 'package:instagram_clone_app/features/home/domain/repository/profile_repository.dart';
import 'package:instagram_clone_app/features/home/domain/usecases/signout.dart';
import 'package:instagram_clone_app/features/home/presentation/bloc/signout_cubit/signout_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

const _localhost = 'localhost';
//const _androidHost = '10.0.2.2';

Future<void> init() async {
  try {
    // Bloc | Cubit
    sl.registerFactory(() => WatchAuthStateCubit(sl()));
    sl.registerFactory(
      () => AuthBloc(
        signinWithEmailAndPassword: sl(),
        signupWithEmailAndPassword: sl(),
      ),
    );
    sl.registerFactory(() => PassResetCubit(sl()));
    sl.registerFactory(() => SignoutCubit(sl()));

    // UseCases
    sl.registerLazySingleton<WatchAuthState>(() => WatchAuthState(sl()));
    sl.registerLazySingleton(() => SigninWithEmailAndPassword(sl()));
    sl.registerLazySingleton(() => SignupWithEmailAndPassword(sl()));
    sl.registerLazySingleton(() => SendPassResetEmail(sl()));
    sl.registerLazySingleton(() => Signout(sl()));

    // Repository
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()),
    );

    sl.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(auth: sl()),
    );

    // Core
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    // External
    sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker.instance,
    );

    sl.registerLazySingleton(() => http.Client());

    // Создаем auth как ленивый синглтон, чтобы создавать объект при первом обращении к нему (для FirebaseAuth не нужен await)
    sl.registerLazySingleton<FirebaseAuth>(() {
      final auth = FirebaseAuth.instance;

      if (kDebugMode) {
        auth.useAuthEmulator(_localhost, 9099);
      }

      return auth;
    });
  } catch (e) {
    print('Di init error: $e');
  }
}
