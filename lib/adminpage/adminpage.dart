import 'package:cbms/adminpage/adminpagemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

final user = FirebaseAuth.instance.currentUser!;

class _AdminPageState extends State<AdminPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    print(user.email);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(user.email as String),
            SizedBox(height: 10),
            Text(
              'User ID :' + user.uid,
              style: TextStyle(fontSize: 12),
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
