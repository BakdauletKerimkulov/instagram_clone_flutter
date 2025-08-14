import 'package:flutter/material.dart';

void showMessage(BuildContext context, {String? message}) {
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
