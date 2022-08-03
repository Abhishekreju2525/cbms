import 'package:cbms/profiles/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:cbms/edit_user_profile.dart';
import 'package:cbms/finePayment.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileMenu extends StatelessWidget {
  const UserProfileMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GridView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => editProfile()));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 196, 161, 202),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 23,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "View/edit profile",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 233, 221, 167),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history_toggle_off,
                        size: 23,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Purchase history",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => fineScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 245, 179, 201),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.currency_rupee,
                        size: 23,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Fines & dues",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 129, 182, 207),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.ramp_left,
                        size: 23,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "View routes & buses",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 245, 179, 201),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mark_email_unread,
                        size: 23,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Notifications",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 245, 179, 201),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        size: 23,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Settings",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 245, 179, 201),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        size: 23,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                      ),
                      Expanded(
                          child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                    ],
                  ),
                ),
              ),
            ],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 40,
              childAspectRatio: 5,
            ),
          ),
        ),
      ),
    );
  }
}
