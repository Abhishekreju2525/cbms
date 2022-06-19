import 'package:cbms/main.dart';
import 'package:cbms/BottomNavigationBar.dart';
import 'package:flutter/material.dart';
class NavigationBar extends StatefulWidget {
   NavigationBar ({Key? key}) : super(key: key);
 
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}
 

 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text('E-pass'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            title: Text('Ticket'),
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black[800],
        onTap: _onItemTapped,
      ),
    );
  }
}