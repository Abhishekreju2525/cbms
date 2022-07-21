import 'package:cbms/BottomNavigationBar.dart';
import 'package:cbms/adminDashboard.dart';
import 'package:cbms/dashboardScreen.dart';
import 'package:cbms/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'viewPass.dart';

class passScreen extends StatefulWidget {
  @override
  State<passScreen> createState() => _passScreenState();
}

DateTime? expiryDate;

final curDate = DateTime.now();
final user = FirebaseAuth.instance.currentUser!;

class _passScreenState extends State<passScreen> {
  final renewalDays = expiryDate?.difference(curDate).inDays;

  late bool status = true;
  Future<dynamic> getpassData() async {
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
  }

  verifyPass() {
    // print(renewalDays);
    if ((renewalDays ?? 0) < 5) {
      status = false;
      print("status is $status");
    } else {
      status = true;
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

  Future<dynamic> getData() {
    final user = FirebaseAuth.instance.currentUser!;
    final DocumentReference<Map<String, dynamic>> _docRef =
        FirebaseFirestore.instance.collection('pass_data').doc(user.uid);
    print("user uid first is :::" + user.uid);
    return Future.delayed(Duration(seconds: 0), () async {
      DocumentSnapshot docSnap = await _docRef.get();

      // Get data from docs and convert map to List
      final snapData = docSnap.data() as Map<String, dynamic>;

      // print('role : $role');

      // print(snapData);
      return snapData;
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
                final data = snapshot.data as Map<String, dynamic>;

                print("Snapshot data ::: $data");
                if (data['status'] == "true") {
                  return SafeArea(
                    child: Scaffold(
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
                                body: Container(
                                    child: Center(
                                        child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          data['purchase date']
                                              .toDate()
                                              .toString()),
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
                        future: getpassData(),
                      ),
                    ),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: Color.fromARGB(255, 248, 248, 248),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'Buy bus ticket here',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 53, 53, 53),
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text('No active pass found'),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const paymentPage()),
                                );
                              },
                              child: Text('Renew now'))
                        ],
                      ),
                    ),
                  );
                }
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
