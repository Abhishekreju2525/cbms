import 'package:cbms/edit_user_profile.dart';
import 'package:cbms/finePayment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cbms/profiles/profilemenu.dart';
import 'package:cbms/profiles/profilepic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "View/edit profile",
            icon: "MdiIcons.sword",
            press: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => editProfile()))
            },
          ),
          ProfileMenu(
            text: "Purchase history",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Fines & dues",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => fineScreen()));
            },
          ),
          ProfileMenu(
            text: "View routes & buses",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
          // ProfileMenu(
          //   text: "Settings",
          //   icon: "assets/icons/Log out.svg",
          //   press: () {},
          // ),
          ProfileMenu(
            text: "Log out",
            icon: "assets/icons/Log out.svg",
            press: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
