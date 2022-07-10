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

  Future signIn() async {
    //Loading Circle
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim());
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
                          'Sign in',
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
                              child: Text('Forgot Password?')),
                        ],
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: signIn,
                        child: const Text('Submit'),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Not a member?'),
                          TextButton(
                              onPressed: widget.showRegisterPage,
                              child: Text(
                                'Sign up now',
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
