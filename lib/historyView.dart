import 'package:cbms/passhistory.dart';
import 'package:cbms/tickethistory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class historyView extends StatelessWidget {
  const historyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          // add tabBarTheme
          tabBarTheme: const TabBarTheme(
            labelColor: Color.fromARGB(255, 78, 90, 161),
            labelStyle: TextStyle(
                color: Color.fromARGB(255, 182, 110, 141)), // color for text
          )),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: Color.fromARGB(255, 37, 51, 90),
            tabs: [
              Tab(icon: Icon(Icons.contacts), text: "Pass"),
              Tab(icon: Icon(Icons.camera_alt), text: "Ticket")
            ],
          ),
          body: TabBarView(children: [passHistory(), ticketHistory()]),
        ),
      ),
    );
  }
}
