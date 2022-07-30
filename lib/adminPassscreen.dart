import 'package:cbms/BottomNavigationBar.dart';
import 'package:cbms/adminDashboard.dart';
import 'package:cbms/dashboardScreen.dart';
import 'package:cbms/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/src/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class adminpassScreen extends StatefulWidget {
  String scanUID;
  adminpassScreen(this.scanUID, QRViewController controller);

  @override
  State<adminpassScreen> createState() => _adminpassScreenState();
}

DateTime? expiryDate;

final curDate = DateTime.now();
final user = FirebaseAuth.instance.currentUser!;

class _adminpassScreenState extends State<adminpassScreen> {
  late bool status = true;

  String get scanUID => widget.scanUID;

  get renewalDays => null;

  Future<dynamic> getpassData() async {
    print("success : $scanUID");

    DocumentReference<Map<String, dynamic>> _docRef =
        await FirebaseFirestore.instance.collection('pass_data').doc(scanUID);
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

  Future<dynamic> getData() async {
    final user = FirebaseAuth.instance.currentUser!;
    final DocumentReference<Map<String, dynamic>> _docRef =
        await FirebaseFirestore.instance.collection('pass_data').doc(scanUID);

    return Future.delayed(Duration(seconds: 0), () async {
      DocumentSnapshot docSnap = await _docRef.get();

      // Get data from docs and convert map to List
      final snapData = docSnap.data() as Map<String, dynamic>;

      return snapData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final renewalDays = expiryDate?.difference(curDate).inDays;
    print("success : $scanUID");
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
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
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
                                      Text("User ID  : " + scanUID),
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
                                      Row(
                                        children: [
                                          Text(
                                            "Active Pass found",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 30,
                                          )
                                        ],
                                      ),
                                      // Text(
                                      //   "$renewalDays days left for renewal.",
                                      //   style: TextStyle(
                                      //       color: Colors.red,
                                      //       fontWeight: FontWeight.bold,
                                      //       fontSize: 20),
                                      // ),
                                      SizedBox(height: 30),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Scan another")),
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
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "No Active Pass found",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  Icon(
                                    Icons.cancel_rounded,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      camera:
                                      true;
                                    });
                                  },
                                  child: Text("Scan another")),
                            ],
                          ),
                        ),
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
