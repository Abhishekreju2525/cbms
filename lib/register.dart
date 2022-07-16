import 'dart:ffi';

import 'package:cbms/loginScreen.dart';
import 'package:cbms/main.dart';
import 'package:cbms/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({Key? key, required this.showLoginPage})
      : super(key: key);

  final VoidCallback showLoginPage;

  @override
  State<registerScreen> createState() => _registerScreen();
}

class _registerScreen extends State<registerScreen> {
  // final _confirmpasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
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
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
    );
    final user = FirebaseAuth.instance.currentUser!;
    print(user.uid);
    addUserDetails(
        _nameController.text.trim(), _usernameController.text.trim());

    //pop the loading circle
    Navigator.of(context).pop();
  }

  Future addUserDetails(String name, String email) async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'name': name,
      'email': email,
      'role': 'user',
    });
    FirebaseFirestore.instance
        .collection("pass_data")
        .doc(user.uid)
        .set({'status': 'false'}).onError(
            (e, _) => print("Error writing document: $e"));
  }

  @override
  Widget build(BuildContext context) {
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
                          'Register now',
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
                        controller: _usernameController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: "Email",
                        ),
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        controller: _passwordController, // <= NEW
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: "Password",
                        ),
                      ),
                    ),
                    // Container(
                    //   child: TextFormField(
                    //     controller: _confirmpasswordController, // <= NEW
                    //     obscureText: true,
                    //     decoration: InputDecoration(
                    //       icon: Icon(Icons.lock_outline),
                    //       labelText: "Confirm Password",
                    //     ),
                    //   ),
                    // ),
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
                        child: const Text('Sign up'),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already a member?'),
                          TextButton(
                              onPressed: widget.showLoginPage,
                              child: Text(
                                'Log in now',
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      ),
                    )
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
