import 'package:cbms/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
      backgroundColor: Color.fromARGB(255, 205, 222, 255),
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 25),
                      SizedBox(height: 25),
                      Text('Admin ' + user.email!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 20),
                      Text(
                        'User ID :' + user.uid,
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Card(
                                      color: Color.fromARGB(255, 255, 197, 226),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 10),
                                              Text(
                                                  "Tap here to scan & verify E-pass/ticket"),
                                              SizedBox(height: 10),
                                            ]),
                                      ),
                                    ),
                                    Icon(Icons.qr_code_scanner),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
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
          ],
        ),
      ),
    );
  }
}
