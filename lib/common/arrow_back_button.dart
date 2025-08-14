import 'package:flutter/material.dart';

IconButton arrowBackButton(BuildContext context) {
  return IconButton(
    onPressed: () => Navigator.pop(context),
    icon: Icon(Icons.arrow_back),
  );
}
