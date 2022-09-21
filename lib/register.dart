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
  bool _isObscure = true;

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
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
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
    FirebaseFirestore.instance
        .collection("ticket_data")
        .doc(user.uid)
        .set({'status': 'false'}).onError(
            (e, _) => print("Error writing document: $e"));
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
                      height: 75,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          'Register now',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF3C2E63),
                            fontWeight: FontWeight.w600,
                            fontSize: 34,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 55,
                    ),
                    Container(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Name",
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
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
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
                      height: 65,
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
                        onPressed: signUp,
                        child: const Text('Sign up'),
                      ),
                    ),
                    SizedBox(
                      height: 175,
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
