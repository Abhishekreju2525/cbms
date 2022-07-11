import 'package:cbms/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class adminDash extends StatefulWidget {
  const adminDash({Key? key}) : super(key: key);

  @override
  State<adminDash> createState() => _adminDashState();
}

class _adminDashState extends State<adminDash> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            // FloatingActionButton(
            //   backgroundColor: Colors.green,
            //   child: Icon(Icons.add),
            //   onPressed: () {
            //     FirebaseFirestore.instance
            //         .collection('data')
            //         .add({'text': 'data added through app'});
            //   },
            // ),
            //app bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25),
                      SizedBox(height: 25),
                      Text('Admin ' + user.email!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 20),
                    ],
                  ),
                  //profile picture
                ],
              ),
            ),
            SizedBox(height: 25),

            //card

            //card

            SizedBox(height: 25),

            //horizontal listview

            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                FirebaseFirestore.instance.clearPersistence();
              },
              color: Colors.amber,
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
