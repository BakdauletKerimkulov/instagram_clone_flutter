import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_app/app_config.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/pass_reset_cubit/pass_reset_cubit.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/signin_bloc/auth_bloc.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/watch_auth_state_cubit/auth_state.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/watch_auth_state_cubit/watch_auth_state_cubit.dart';
import 'package:instagram_clone_app/features/home/presentation/bloc/signout_cubit/signout_cubit.dart';
import 'package:instagram_clone_app/locator_service.dart' as di;

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchAuthStateCubit>(
          create: (context) => di.sl<WatchAuthStateCubit>(),
        ),
        BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
        BlocProvider<PassResetCubit>(create: (_) => di.sl<PassResetCubit>()),
        BlocProvider(create: (_) => di.sl<SignoutCubit>()),
      ],
      child: BlocBuilder<WatchAuthStateCubit, AuthState>(
        builder: (context, authState) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: myGoRouter(authState),
        ),
      ),
    );
  }
}

/* 
  auth emulator = 9099
  firestore emulator = 8080
  database emulator = 9000
  storage emulator = 9199
*/
