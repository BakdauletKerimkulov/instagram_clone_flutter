import 'package:flutter/material.dart';
import 'package:instagram_clone_app/features/auth/presentation/widgets/auth_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthStateWidget(isLogin: false);
  }
}
