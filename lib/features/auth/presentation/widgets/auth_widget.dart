import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_app/common/app_colors.dart';
import 'package:instagram_clone_app/common/arrow_back_button.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/signin_bloc/auth_bloc.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/signin_bloc/auth_event.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/signin_bloc/auth_state.dart';
import 'package:instagram_clone_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:instagram_clone_app/features/auth/presentation/pages/signup_page.dart';

class AuthStateWidget extends StatefulWidget {
  final bool isLogin;

  const AuthStateWidget({super.key, this.isLogin = true});

  @override
  State<AuthStateWidget> createState() => _AuthStateWidgetState();
}

class _AuthStateWidgetState extends State<AuthStateWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();

  bool _hidePass = true;

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() => setState(() {}));
    _passFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();

    _emailFocusNode.dispose();
    _passFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isLogin ? null : AppBar(leading: arrowBackButton(context)),
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            _showMessage(context, message: state.message);
          } else if (state is Authenticated) {
            context.go('/home');
          } else if (state is Unauthenticated) {
            _showMessage(context, message: "User doesn't exist");
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 80),
                  SvgPicture.asset(
                    'assets/icons/instagram_main_icon.svg',
                    width: 150,
                    height: 150,
                  ),
                  Expanded(
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildTextField(
                              controller: _emailController,
                              label: 'Email or username',
                              focusNode: _emailFocusNode,
                              isPassword: false,
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              controller: _passController,
                              label: 'Password',
                              focusNode: _passFocusNode,
                              isPassword: true,
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _submitForm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[700],
                                  foregroundColor: Colors.white,
                                ),
                                child: state is AuthLoading
                                    ? _progress()
                                    : Text(
                                        widget.isLogin ? 'Log in' : 'Sign up',
                                      ),
                              ),
                            ),
                            if (widget.isLogin)
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResetPasswordPage(
                                        email: _emailController.text.isNotEmpty
                                            ? _emailController.text
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (widget.isLogin)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,
                          side: BorderSide(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => RegisterPage()),
                          );
                        },
                        child: Text('Create new account'),
                      ),
                    ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox _progress() {
    return SizedBox(
      height: 20.0,
      width: 20.0,
      child: CircularProgressIndicator(strokeWidth: 2.0, color: Colors.white),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required FocusNode focusNode,
    required bool isPassword,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: isPassword
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      obscureText: isPassword ? _hidePass : false,
      autocorrect: false,
      enableSuggestions: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: focusNode.hasFocus
            ? IconButton(
                icon: Icon(
                  isPassword
                      ? (_hidePass ? Icons.visibility : Icons.visibility_off)
                      : Icons.clear,
                ),
                onPressed: () {
                  if (isPassword) {
                    setState(() => _hidePass = !_hidePass);
                  } else {
                    controller.clear();
                  }
                },
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.black87, width: 1.0),
        ),
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? '$label is required' : null,
    );
  }

  void _submitForm() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_emailController.text);
      print(_passController.text);
      context.read<AuthBloc>().add(
        widget.isLogin
            ? SigninEvent(
                email: _emailController.text,
                password: _passController.text,
              )
            : SignupEvent(
                email: _emailController.text,
                password: _passController.text,
              ),
      );
    } else {
      _showMessage(context, message: 'Form is not valid');
    }
  }

  void _showMessage(BuildContext context, {String? message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.grey,
        content: Text(
          message!,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
