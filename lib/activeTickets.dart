import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class activeTickets extends StatefulWidget {
  const activeTickets({Key? key}) : super(key: key);

  @override
  State<activeTickets> createState() => _activeTicketsState();
}

final user = FirebaseAuth.instance.currentUser!;

class _activeTicketsState extends State<activeTickets> {
  final cdate = DateTime.now();
  DateTime? purchaseDate;
  final curDate = DateTime.now();

  DocumentReference<Map<String, dynamic>> _docRef =
      FirebaseFirestore.instance.collection('pass_data').doc(user.uid);

  Future<dynamic> getData() async {
    return Future.delayed(Duration(seconds: 0), () async {
      // Get docs from collection reference
      DocumentSnapshot docSnap = await _docRef.get();

      // Get data from docs and convert map to List
      final snapData = docSnap.data() as Map<String, dynamic>;
      purchaseDate = snapData['Expiry'].toDate();
      print("purchase date ::: $purchaseDate");
      print(curDate);
      // print(snapData);
      return purchaseDate as DateTime;
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
                final data = snapshot.data as DateTime;

                return Scaffold(
                  body: Container(
                      child: Center(
                          child: Column(children: [
                    QrImage(data: user.uid, size: 120),
                    ElevatedButton(onPressed: () {}, child: Text('Renew now'))
                  ]))),
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
