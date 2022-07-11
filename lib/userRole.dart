import 'package:cbms/BottomNavigationBar.dart';
import 'package:cbms/adminDashboard.dart';
import 'package:cbms/dashboardScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class userRole extends StatefulWidget {
  @override
  State<userRole> createState() => _userRoleState();
}

class _userRoleState extends State<userRole> {
  Future<String> getData() {
    String? role;
    return Future.delayed(Duration(seconds: 0), () async {
      final firebaseUser = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        final data = ds.data() as Map<String, dynamic>;

        role = data['role'];
        print(role);
        return role;
        // print(data['role']);
        // role = data['role'];
      }).catchError((e) {
        print(e);
      });
      print('role : $role');
      String role1 = role as String;
      return role1;
      // throw Exception("Custom Error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                final data = snapshot.data as String;

                if (data == 'user')
                  return dashboardScreen();
                else
                  return adminDash();
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getData(),
        ),
      ),
    );
  }

  routeUser(String? data) {
    if (data == 'user') {
      print('routed to user');
      return dashboardScreen();
    } else if (data == 'admin') {
      print('routed to admin');
      return adminDash();
    } else {
      return Text('Invalid authentication');
    }
  }
}
