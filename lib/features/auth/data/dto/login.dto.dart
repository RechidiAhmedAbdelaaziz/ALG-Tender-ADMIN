import 'package:flutter/material.dart';

class LoginDto {
  final TextEditingController email;
  final TextEditingController password;

  LoginDto()
      : email = TextEditingController(),
        password = TextEditingController();

  Map<String, dynamic> get body => {
        'login': email.text,
        'password': password.text,
      };
}
