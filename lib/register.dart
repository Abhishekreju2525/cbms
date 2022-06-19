import 'dart:ffi';

import 'package:cbms/loginScreen.dart';
import 'package:cbms/main.dart';
import 'package:cbms/register.dart';
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
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
    );
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
                        controller: _usernameController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: "Username",
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