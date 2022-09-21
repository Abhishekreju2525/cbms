import 'dart:ui';

import 'package:cbms/dashboardScreen.dart';
import 'package:cbms/main.dart';
import 'package:cbms/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'forgot_pw_screen.dart';

class loginScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const loginScreen({Key? key, required this.showRegisterPage})
      : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var errormessage;
  bool _isObscure = true;
  Future signIn() async {
    //Loading Circle
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _usernameController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      // print('Failed with error code: ${e.code}');
      // print(e.message);
      // if (e.code == "user-not-found") {
      //   errormessage = "Account doesn't exists!";
      // } else if (e.code == "") {}
      Navigator.of(context).pop();
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.code),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
    //pop the loading circle
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 85,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Sign in',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF3C2E63),
                            fontWeight: FontWeight.w700,
                            fontSize: 34,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    Container(
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Email",
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
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        controller: _passwordController, // <= NEW
                        obscureText: _isObscure,

                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Password",
                            filled: true,
                            fillColor: Color(0xFFFFEBEB),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 19, horizontal: 20),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(21)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ForgotPasswordPage();
                                }));
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(color: Color(0xFF3C2E63)),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3C2E63),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                        ),
                        onPressed: signIn,
                        child: const Text(
                          'Log in',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 205,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          TextButton(
                              onPressed: widget.showRegisterPage,
                              child: Text(
                                'Sign up now',
                                style: TextStyle(
                                    color: Color(0xFF3C2E63),
                                    fontWeight: FontWeight.w700),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
