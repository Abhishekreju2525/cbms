import 'dart:io';

import 'package:cbms/payment.dart';
import 'package:cbms/ticketScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'BottomNavigationBar.dart';
import 'adminDashboard.dart';

class adminviewPass extends StatefulWidget {
  const adminviewPass({Key? key}) : super(key: key);

  @override
  State<adminviewPass> createState() => _adminviewPassState();
}

DateTime? expiryDate;

final curDate = DateTime.now();
final user = FirebaseAuth.instance.currentUser!;

class _adminviewPassState extends State<adminviewPass> {
  Future<dynamic> getData() async {
    return Future.delayed(Duration(seconds: 1), () async {
      final user = FirebaseAuth.instance.currentUser!;
      DocumentReference<Map<String, dynamic>> _docRef =
          FirebaseFirestore.instance.collection('pass_data').doc(user.uid);
      DocumentSnapshot docSnap = await _docRef.get();

      // Get data from docs and convert map to List
      final sData = docSnap.data() as Map<String, dynamic>;
      expiryDate = sData['Expiry'].toDate();

      print("expiry date ::: $expiryDate");
      print(curDate);

      return sData;
    });
  }

  final renewalDays = expiryDate!.difference(curDate).inDays;

  late bool status = false;

  verifyPass() {
    final curDate = DateTime.now();
    // print(renewalDays);
    if (renewalDays < 5) {
      status = true;
      print("status is $status");
    } else {
      status = false;
      print("status is $status");
    }
    print(status);

    return ElevatedButton(
        onPressed: status
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const paymentPage()),
                );
              }
            : null,
        child: Text('Renew now'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 234, 171, 192),
        body: FutureBuilder(
          builder: (ctx, dsnap) {
            // Checking if future is resolved or not
            if (dsnap.connectionState == ConnectionState.done) {
              final user = FirebaseAuth.instance.currentUser!;
              // If we got an error
              if (dsnap.hasError) {
                final user = FirebaseAuth.instance.currentUser!;
                return Center(
                  child: Text(
                    '${dsnap.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (dsnap.hasData) {
                final user = FirebaseAuth.instance.currentUser!;
                final data = dsnap.data as Map<String, dynamic>;
                // print(data);

                return Scaffold(
                  backgroundColor: Color.fromARGB(255, 234, 171, 192),
                  body: Container(
                      color: Color.fromARGB(255, 248, 202, 217),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),
                            QrImage(data: user.uid, size: 120),
                            SizedBox(height: 50),
                            Text("User ID  : " + user.uid),
                            const Divider(
                              height: 30,
                              thickness: 0.5,
                              indent: 0,
                              endIndent: 0,
                              color: Colors.grey,
                            ),
                            Text("Amount paid : " + data['amount']),
                            const Divider(
                              height: 30,
                              thickness: 0.3,
                              indent: 0,
                              endIndent: 0,
                              color: Colors.grey,
                            ),
                            Text("Issue date : " +
                                data['purchase date'].toString()),
                            const Divider(
                              height: 40,
                              thickness: 0.5,
                              indent: 0,
                              endIndent: 0,
                              color: Colors.grey,
                            ),
                            Text("Expiry date : " + data['Expiry'].toString()),
                            const Divider(
                              height: 40,
                              thickness: 0.5,
                              indent: 0,
                              endIndent: 0,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 30),
                            Text(
                              "$renewalDays days left for renewal.",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(height: 30),
                            verifyPass(),
                          ],
                        ),
                      ))),
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
