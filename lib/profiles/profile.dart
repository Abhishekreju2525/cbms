import 'package:flutter/material.dart';
import 'package:cbms/profiles/body.dart';

class profile extends StatelessWidget {
  static String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
