import 'dart:io';

import 'package:cbms/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'BottomNavigationBar.dart';
import 'adminDashboard.dart';

class viewPass extends StatefulWidget {
  const viewPass({Key? key}) : super(key: key);

  @override
  State<viewPass> createState() => _viewPassState();
}

final user = FirebaseAuth.instance.currentUser!;
DateTime? expiryDate;
final curDate = DateTime.now();

DocumentReference<Map<String, dynamic>> _docRef =
    FirebaseFirestore.instance.collection('pass_data').doc(user.uid);

Future<dynamic> getData() async {
  // Get docs from collection reference
  DocumentSnapshot docSnap = await _docRef.get();

  // Get data from docs and convert map to List
  final snapData = docSnap.data() as Map<String, dynamic>;
  expiryDate = snapData['Expiry'].toDate();
  print("expiry date ::: $expiryDate");
  print(curDate);
  // print(snapData);
  return snapData;
}

final renewalDays = expiryDate!.difference(curDate).inDays;

class _viewPassState extends State<viewPass> {
  late bool status = false;
  verifyPass() {
    print(renewalDays);
    if (renewalDays < 5) {
      status = true;
      print("status is $status");
    } else {
      status = false;
    }
    return ElevatedButton(
        onPressed: status ? () => () {} : null, child: Text('Renew now'));
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
                final data = snapshot.data as Map<String, dynamic>;
                // print(data);
                expiryDate = data['Expiry'].toDate();

                return Scaffold(
                  body: Container(
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
                            data['purchase date'].toDate().toString()),
                        const Divider(
                          height: 40,
                          thickness: 0.5,
                          indent: 0,
                          endIndent: 0,
                          color: Colors.grey,
                        ),
                        Text("Expiry date : " +
                            data['Expiry'].toDate().toString()),
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
