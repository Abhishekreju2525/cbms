import 'package:cbms/loginScreen.dart';
import 'package:cbms/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class registerScreen extends StatelessWidget {
  const registerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      body: Column(
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
                        'First time user?',
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 34,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueAccent)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => loginScreen()),
                        );
                      },
                      child: const Text('Submit'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
