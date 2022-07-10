/*import 'package:cbms/auth_page.dart';
import 'package:cbms/dashboardScreen.dart';
import 'package:cbms/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'adminDashboard.dart';
import 'dashboardScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? role;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final firebaseUser = FirebaseAuth.instance.currentUser!;
          FirebaseFirestore.instance.clearPersistence();
          FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .get()
              .then((ds) {
            final data = ds.data() as Map<String, dynamic>;
            role = null;
            role = data['role'];
            print(role);
            // print(data['role']);
            // role = data['role'];
          }).catchError((e) {
            print(e);
          });
          return userRole(role);
        } else {
          return AuthPage();
        }
      },
    ));
  }

  Widget userRole(String? role) {
    FirebaseFirestore.instance.clearPersistence();
    if (role == 'admin') {
      return adminDash();
    } else {
      return dashboardScreen();
    }
  }
}
*/

import 'package:cbms/auth_page.dart';
import 'package:cbms/dashboardScreen.dart';
import 'package:cbms/userRole.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'dashboardScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureDemoPage();
        } else {
          return AuthPage();
        }
      },
    ));
  }
}
