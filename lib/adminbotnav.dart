import 'package:cbms/adminDashboard.dart';
import 'package:cbms/adminpage/adminpage.dart';
import 'package:cbms/adminprofile.dart';
import 'package:cbms/historyView.dart';
import 'package:cbms/passhistory.dart';
import 'package:cbms/tickethistory.dart';
import 'package:flutter/material.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({Key? key}) : super(key: key);

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  int _pageIndex = 0;

  final pages = [
    adminDash(),
    AdminProf(),
    historyView(),
    AdminPage(),
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
              icon: Icon(Icons.drive_file_rename_outline), label: 'Edit'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Transactions'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
