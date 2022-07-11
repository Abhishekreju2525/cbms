import 'package:cbms/payment.dart';
import 'package:cbms/userRole.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cbms/payment.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:restart_app/restart_app.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class dashboardScreen extends StatefulWidget {
  const dashboardScreen({Key? key}) : super(key: key);
  // final String fullName;
  // final String company;
  // final int age;
  // AddUser(this.fullName, this.company, this.age);

  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            //app bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hi ' + user.email!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 20),
                      Text(
                        'Find Your Bus',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  //profile picture
                  Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.person)),
                ],
              ),
            ),
            SizedBox(height: 25),

            //card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Text("Vidhyanagar",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                ]),
              ),
            ),
            SizedBox(height: 25),

            //card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  Text("College",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                ]),
              ),
            ),
            SizedBox(height: 25),

            //horizontal listview
            Container(
              height: 80,
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.deepPurple[100],
                    child: Row(
                      children: [Text('No 1')],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 80,
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.deepPurple[100],
                    child: Row(
                      children: [
                        Text('8:55'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const paymentPage()),
                );
              },
              color: Colors.greenAccent,
              child: Text('Payment'),
            ),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.amber,
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
