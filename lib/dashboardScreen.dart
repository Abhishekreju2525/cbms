import 'package:cbms/busView.dart';
import 'package:cbms/payment.dart';
import 'package:cbms/profiles/category_card.dart';
import 'package:cbms/userRole.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cbms/payment.dart';
import 'package:flutter/rendering.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:restart_app/restart_app.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import 'getbuslist.dart';

class dashboardScreen extends StatefulWidget {
  const dashboardScreen({Key? key}) : super(key: key);
  // final String fullName;
  // final String company;
  // final int age;
  // AddUser(this.fullName, this.company, this.age);

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final _routeController = TextEditingController();

  @override
  final List<String> docIDs = [];
  String routeselect = "Kasaragod";

  // Future getDocId() async {
  //   await FirebaseFirestore.instance
  //       .collection('bus')
  //       .get()
  //       .then((snapshot) => snapshot.docs.forEach((document) {
  //             print(document.reference);
  //             docIDs.add(document.reference.id);
  //           }));
  // }

  final List<String> _docIDs = [];
  final List<String> _fees = [];

  String? location;

  Future<List<Map<dynamic, dynamic>>> getDocIds() async {
    Future.delayed(Duration(seconds: 0));
    await FirebaseFirestore.instance
        .collection('bus')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              _docIDs.add(document.reference.id);
              _fees.add(document.data()['route']);
            }));
    List<DocumentSnapshot> _templist;
    List<Map<dynamic, dynamic>> list = [];
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("bus");
    QuerySnapshot collectionSnapshot = await collectionRef.get();

    _templist = collectionSnapshot.docs.toList();

    list = _templist.map((DocumentSnapshot docSnapshot) {
      return docSnapshot.data() as Map<dynamic, dynamic>; // <--- Typecast this.
    }).toList();

    return list;
  }

  ValueNotifier<String> amt = ValueNotifier("none");
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: getDocIds(),
          builder: (context, snapshot) {
            final _data = snapshot.data as List<Map<dynamic, dynamic>>;
            return Scaffold(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              body: SafeArea(
                child: Column(
                  children: [
                    //app bar
                    SizedBox(height: 45),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hi, ' + user.email!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Color(0xFF3C2E63))),
                              SizedBox(height: 20),
                            ],
                          ),

                          //profile picture
                          Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.person)),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        children: [
                          Text(
                            'Find Your Bus',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Color(0xFF3C2E63)),
                          ),
                        ],
                      ),
                    ),
                    //card
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 25),
                      child: Container(
                        child: TextField(
                          enabled: false,
                          readOnly: true,
                          enableInteractiveSelection: false,
                          // controller: _usernameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.pin_drop),
                            labelText: "College",
                            filled: true,
                            fillColor: Color(0xFFFFEBEB),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 19, horizontal: 20),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(21)),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_downward_sharp),
                        Icon(Icons.arrow_upward),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 25),
                      child: DropdownButtonFormField(
                        hint: Text(_docIDs[0]),
                        items: _docIDs.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (value) {
                          location = value as String;
                          // print(location);
                          // print(_data[0][value]);
                          amt.value = location as String;
                          print(amt.value);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.pin_drop),
                          labelText: "Select your route",
                          filled: true,
                          fillColor: Color(0xFFE9F1FF),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 19, horizontal: 20),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(21)),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Available bus",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3C2E63)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        child: Container(
                            child: ValueListenableBuilder(
                                valueListenable: amt,
                                builder: (BuildContext context, String amount,
                                    Widget? child) {
                                  return ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          color: Color.fromARGB(
                                              255, 255, 208, 212),
                                          child: getBusList(
                                              documentId: amt.value));
                                    },
                                  );
                                })),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30),
                      child: Card(
                        color: Color.fromARGB(255, 255, 245, 215),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    color: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Scan QR to verify E-Pass',
                                            style: TextStyle(fontSize: 16))),
                                  ),
                                  QrImage(data: user.uid, size: 80),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
