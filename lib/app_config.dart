import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_app/features/add/presentation/pages/add_post_screen.dart';
import 'package:instagram_clone_app/features/add/presentation/pages/add_reels_screen.dart';
import 'package:instagram_clone_app/features/add/presentation/pages/add_screen.dart';
import 'package:instagram_clone_app/features/add/presentation/pages/camera_screen.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/watch_auth_state_cubit/auth_state.dart';
import 'package:instagram_clone_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:instagram_clone_app/features/auth/presentation/pages/signin_page.dart';
import 'package:instagram_clone_app/features/auth/presentation/pages/signup_page.dart';
import 'package:instagram_clone_app/features/home/presentation/pages/home_screen.dart';
import 'package:instagram_clone_app/features/home/presentation/pages/profile_screen.dart';
import 'package:instagram_clone_app/features/home/presentation/pages/reels_screen.dart';
import 'package:instagram_clone_app/features/home/presentation/pages/search_screen.dart';
import 'package:instagram_clone_app/root_screen.dart';

GoRouter myGoRouter(AuthState authState) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      log(authState.toString());
      //перенавление на основе состояния кубита
      if (authState is Unauthenticated &&
          !state.uri.toString().startsWith('/login') &&
          !state.uri.toString().startsWith('/register')) {
        return '/login';
      }

      if (authState is Authenticated &&
          (state.uri.toString() == '/login' ||
              state.uri.toString() == '/register')) {
        return '/home';
      }

      return null;
    },
    routes: [
      //Auth features
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: '/register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: '/resetPassword',
            builder: (context, state) => const ResetPasswordPage(),
          ),
        ],
      ),

      //main features
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          if (state.fullPath == '/add/add_post/camera') {
            return Scaffold(body: navigationShell);
          } else {
            return RootScreen(navigationShell: navigationShell);
          }
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                builder: (context, state) => SearchScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/add',
                builder: (context, state) => AddScreen(),
                routes: [
                  GoRoute(
                    path: 'add_reels',
                    builder: (context, state) => const AddReelsScreen(),
                  ),
                  GoRoute(
                    path: 'add_post',
                    builder: (context, state) => const AddPostScreen(),
                    routes: [
                      GoRoute(
                        path: 'camera',
                        builder: (context, state) => const CameraScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reels',
                builder: (context, state) => ReelsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
