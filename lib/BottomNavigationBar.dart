import 'package:cbms/dashboardScreen.dart';
import 'package:cbms/profiles/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        onTabChange: (value) {
          if (value == 1) {
            dashboardScreen();
          }
          if (value == 2) {
            dashboardScreen();
          }
          if (value == 3) {
            dashboardScreen();
          }
          if (value == 4) {
            profile();
          }
        },
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.airplane_ticket,
            text: 'E-pass',
          ),
          GButton(
            icon: Icons.confirmation_number,
            text: 'Ticket',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
