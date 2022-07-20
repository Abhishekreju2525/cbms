import 'package:cbms/driverView.dart';
import 'package:cbms/loginScreen.dart';
import 'package:cbms/main.dart';
import 'package:cbms/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class addDriver extends StatefulWidget {
  const addDriver({Key? key}) : super(key: key);

  @override
  State<addDriver> createState() => _addDriver();
}

class _addDriver extends State<addDriver> {
  bool addedDriver = false;
  // final _confirmpasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _mobileController.dispose();
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

    addDriver(_nameController.text.trim(), _mobileController.text.trim());
    Navigator.of(context).pop();

    //pop the loading circle
  }

  Future addDriver(String name, String mobile) async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('driver').doc().set({
      'name': name,
      'mobile': mobile,
    });
    setState(() {
      addedDriver = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (addedDriver == true) {
      addedDriver = false;
      return driverView();
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
                            'Add driver',
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
                          controller: _nameController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Name",
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _mobileController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Mobile",
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
                          child: const Text('Add driver'),
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
