import 'package:cbms/loginScreen.dart';
import 'package:cbms/register.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool ShowLoginPage = true;

  void toggleScreens() {
    setState(() {
      ShowLoginPage = !ShowLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (ShowLoginPage) {
      return loginScreen(showRegisterPage: toggleScreens);
    } else {
      return registerScreen(showLoginPage: toggleScreens);
    }
  }
}
