/*import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class userRoleSelector extends StatefulWidget {
  const userRoleSelector({Key? key}) : super(key: key);

  @override
  State<userRoleSelector> createState() => _userRoleSelectorState();
}

class _userRoleSelectorState extends State<userRoleSelector> {
  String? role;

  Future<String?> fetchRole() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.clearPersistence();
    await FirebaseFirestore.instance
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
    print(role);
    return role;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: fetchRole(),
          builder: ((context, snapshot) {
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
                // Extracting data from snapshot object
                final data = snapshot.data as String;
                return Center(
                  child: Text(
                    '$data',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
            }
          })),
    );
  }
}
*/
import 'package:cbms/adminDashboard.dart';
import 'package:cbms/dashboardScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeeksforGeeks',

      // to hide debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('GeeksforGeeks'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => FutureDemoPage(),
              ),
            ),
            child: Text('Demonstrate FutureBuilder'),
          ),
        ),
      ),
    );
  }
}

class FutureDemoPage extends StatefulWidget {
  @override
  State<FutureDemoPage> createState() => _FutureDemoPageState();
}

class _FutureDemoPageState extends State<FutureDemoPage> {
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
                // Extracting data from snapshot object
                final data = snapshot.data as String;
                // return Center(
                //   child: Text(
                //     '$data',
                //     style: TextStyle(fontSize: 18),
                //   ),
                // );
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

          // Future that needs to be resolved
          // inorder to display something on the Canvas
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
