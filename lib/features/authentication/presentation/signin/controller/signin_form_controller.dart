import 'package:flutter/material.dart';

class SigninFormController {
  final email = TextEditingController();
  final password = TextEditingController();

  void dispose() {
    email.dispose();
    password.dispose();
  }
}
