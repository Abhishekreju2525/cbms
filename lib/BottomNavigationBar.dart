import 'package:cbms/dashboardScreen.dart';
import 'package:cbms/passScreen.dart';
import 'package:cbms/profiles/profile.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _pageIndex = 0;

  final pages = [
    dashboardScreen(),
    passScreen(),
    dashboardScreen(),
    profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: _pageIndex,
        onTap: (newIndex) {
          setState(() {
            _pageIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket), label: 'E-Pass'),
          BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number), label: 'Ticket'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
