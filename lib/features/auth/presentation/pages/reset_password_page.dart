import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_app/common/arrow_back_button.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/pass_reset_cubit/pass_reset_cubit.dart';
import 'package:instagram_clone_app/features/auth/presentation/bloc/pass_reset_cubit/pass_reset_state.dart';

class ResetPasswordPage extends StatefulWidget {
  final String? email;

  const ResetPasswordPage({super.key, this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _emailFocusNode = FocusNode();

  @override
  void initState() {
    _emailFocusNode.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: arrowBackButton(context)),
      body: BlocConsumer<PassResetCubit, PassResetState>(
        listener: (context, state) {
          if (state is PassResetError) {
            _showMessage(context, message: state.message);
          } else if (state is PassResetSent) {
            _showMessage(context, message: 'The message has been sent');
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find your account',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      focusNode: _emailFocusNode,
                      isPassword: false,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Enter your email in the field so we can send you a password reset message',
                      //style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          _submitForm();
                        },
                        child: state is PassResetLoading
                            ? _progress()
                            : Text('Send code'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_emailController.text);
      context.read<PassResetCubit>().sendPassword(_emailController.text);
    }
  }

  SizedBox _progress() {
    return SizedBox(
      height: 20.0,
      width: 20.0,
      child: CircularProgressIndicator(strokeWidth: 2.0, color: Colors.white),
    );
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
}
