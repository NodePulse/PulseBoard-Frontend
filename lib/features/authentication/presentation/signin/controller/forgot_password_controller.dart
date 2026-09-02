import 'package:flutter/material.dart';

class ForgotPasswordController {
  final email = TextEditingController();

  void dispose() {
    email.dispose();
  }
}
