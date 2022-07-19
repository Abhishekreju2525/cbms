import 'package:cbms/adminpage/adminpagemenu.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Abishek S R',
              style: TextStyle(fontSize: 35),
            ),
            Text(
              'Admin ID:2019320',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: AdminPageMenu(),
            )
          ],
        ),
      ),
    );
  }
}
