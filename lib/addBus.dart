import 'package:cbms/driverView.dart';
import 'package:cbms/loginScreen.dart';
import 'package:cbms/main.dart';
import 'package:cbms/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'busView.dart';

class addBus extends StatefulWidget {
  const addBus({Key? key}) : super(key: key);

  @override
  State<addBus> createState() => _addBus();
}

class _addBus extends State<addBus> {
  bool addedBus = false;
  // final _confirmpasswordController = TextEditingController();
  final _regnumController = TextEditingController();
  final _vehnumController = TextEditingController();
  final _routeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _regnumController.dispose();
    _vehnumController.dispose();
    _routeController.dispose();
    // _confirmpasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    //Loading Circle
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    final user = FirebaseAuth.instance.currentUser!;

    addBus(_regnumController.text.trim(), _vehnumController.text.trim(),
        _routeController.text.trim());

    Navigator.of(context).pop();

    //pop the loading circle
  }

  Future addBus(String regnum, String vehnum, String route) async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('bus').doc().set({
      'registration': regnum,
      'vehicle number': vehnum,
      'route': route,
    });
    setState(() {
      addedBus = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (addedBus == true) {
      addedBus = false;
      return busView();
    } else {
      return Material(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 75,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            'Add Bus',
                            style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 34,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Container(
                        child: TextFormField(
                          controller: _regnumController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Registration number",
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _vehnumController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Vehicle number",
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _routeController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Route",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: signUp,
                          child: const Text('Add Bus'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    }
  }
}
