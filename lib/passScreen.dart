import 'package:cbms/BottomNavigationBar.dart';
import 'package:cbms/adminDashboard.dart';
import 'package:cbms/dashboardScreen.dart';
import 'package:cbms/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'viewPass.dart';

class passScreen extends StatefulWidget {
  @override
  State<passScreen> createState() => _passScreenState();
}

class _passScreenState extends State<passScreen> {
  Future<String> getData() {
    String? status;
    return Future.delayed(Duration(seconds: 0), () async {
      final firebaseUser = FirebaseAuth.instance.currentUser!;
      await FirebaseFirestore.instance
          .collection('pass_data')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        final data = ds.data() as Map<String, dynamic>;

        status = data['status'];
        // print(role);
        return status;
        // print(data['role']);
        // role = data['role'];
      }).catchError((e) {
        print(e);
      });
      // print('role : $role');
      String status1 = status as String;
      return status1;
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
                final data = snapshot.data as String?;
                print(data);

                if (data == 'true')
                  return viewPass();
                else
                  return Center(
                    child: Column(
                      children: [
                        Text('No active pass found!'),
                        ElevatedButton(
                            onPressed: () {
                              paymentPage();
                            },
                            child: Text('Renew now')),
                      ],
                    ),
                  );
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
}
