import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone_app/core/error/exception.dart';

abstract class AuthDataSource {
  Future<User?> signUpWithEmail(String email, String password);

  Future<User?> signInWithEmail(String email, String password);

  bool isUserLoggedIn();

  User? getCurrentUser();

  Stream<User?> watchAuthState();

  Future<void> sendPasswordResetEmail(String email);

  void signOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth auth;

  AuthDataSourceImpl({required this.auth});

  @override
  User? getCurrentUser() {
    return auth.currentUser;
  }

  @override
  bool isUserLoggedIn() {
    // TODO: implement isUserLoggedIn
    throw UnimplementedError();
  }

  @override
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException("That user doesn't exist");
      }
      throw AuthException(e.message ?? 'Authentication failed');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Signout has been failed');
    }
  }

  @override
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Authentication failed');
    }
  }

  @override
  Stream<User?> watchAuthState() {
    return auth.authStateChanges();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      print('DataSource method sendPassResetEmail has been called');
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Unknown exception');
    } catch (e) {
      throw AuthException('An unexpected error occured: $e');
    }
  }
}
