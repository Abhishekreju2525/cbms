import 'package:cbms/adminPassscreen.dart';
import 'package:cbms/payment.dart';
import 'package:cbms/qrscanner.dart';
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
  final _useridController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  late String scanUID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.admin_panel_settings),
                    Text(
                      "Admin",
                      style: TextStyle(
                          color: Color.fromARGB(255, 30, 28, 34),
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      "Hi, " + user.email!,
                      style: TextStyle(
                          color: Color(0xFF3C2E63),
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 400,
                padding: EdgeInsets.all(11.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 246, 238, 255),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Title(
                          color: Colors.white,
                          child: Text(
                            "Verify E-Pass/ Ticket",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 27,
                                color: Color.fromARGB(255, 32, 32, 32)),
                          )),
                    ),

                    SizedBox(
                      height: 14,
                    ),
                    //////////////////////
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF3C2E63),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Scanner()),
                                      );
                                    },
                                    child: Text('Tap to scan the QR code')),
                                Icon(
                                  Icons.qr_code_2,
                                  size: 50,
                                )
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    ////////////////////////////
                    Center(
                      child: Container(
                        child: Text(
                          "OR",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 32, 32, 32)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //////////////////////////////
                    Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 0,
                              ),
                              TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Enter user ID',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  // onPressed: () async {
                                  //   scanUID:
                                  //   _useridController.text.trim();
                                  //   this.controller;:_useridController;
                                  //   await Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //           builder: (context) => adminpassScreen(
                                  //               scanUID, controller)));
                                  // },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF3C2E63),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 11, horizontal: 20),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: (() {}),
                                  child: Text("Verify"))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
