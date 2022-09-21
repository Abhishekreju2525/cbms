import 'package:cbms/payment.dart';
import 'package:cbms/profiles/category_card.dart';
import 'package:cbms/userRole.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cbms/payment.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:restart_app/restart_app.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

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
            SizedBox(height: 20),
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
                  Image.asset(
                    'lib/icons/house.png',
                    height: 50,
                  ),
                  SizedBox(
                    width: 20,
                  ),
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
                  Image.asset(
                    'lib/icons/college.png',
                    height: 50,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("College",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                ]),
              ),
            ),
            SizedBox(height: 25),

            Container(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryCard(
                    CategoryName: 'NO:5',
                    iconImagePath: 'lib/icons/number.png',
                  ),
                  CategoryCard(
                    CategoryName: '08:55 am',
                    iconImagePath: 'lib/icons/clock-15133.png',
                  ),
                  CategoryCard(
                    CategoryName: 'KL-14H-0226',
                    iconImagePath: 'lib/icons/bus-icon.png',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            color: Color.fromARGB(255, 255, 224, 131),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Scan QR to verify E-Pass')),
                          ),
                          QrImage(data: user.uid, size: 100),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )

            // MaterialButton(
            //   onPressed: () {
            //     FirebaseAuth.instance.signOut();
            //   },
            //   color: Colors.amber,
            //   child: Text('Sign out'),
            // ),
          ],
        ),
      ),
    );
  }
}
