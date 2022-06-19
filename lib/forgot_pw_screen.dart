import 'package:cbms/auth_page.dart';
import 'package:cbms/loginScreen.dart';
import 'package:cbms/main_page.dart';
import 'package:cbms/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();

    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _usernameController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent! Check your email'),
              actions: [
                TextButton(
                    child: Text("Back to login"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthPage()),
                      );
                      ;
                    })
              ],
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Text(
              "Enter your email and we'll send you a password reset link.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
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
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: passwordReset,
              child: Text("Reset password"),
              color: Colors.deepPurple[200],
            )
          ],
        ),
      ),
    );
  }
}
