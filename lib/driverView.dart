import 'package:cbms/addDriver.dart';
import 'package:cbms/getdriverlist.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class driverView extends StatefulWidget {
  const driverView({Key? key}) : super(key: key);

  @override
  State<driverView> createState() => _driverViewState();
}

class _driverViewState extends State<driverView> {
  final List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('driver')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.00, bottom: 0.00),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addDriver()));
                },
                child: Text('Add')),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (context, index) {
                      return Card(
                          color: Color.fromARGB(255, 255, 208, 212),
                          child: getDriverList(documentId: docIDs[index]));
                    },
                  );
                }),
          )),
        ],
      ),
    );
  }
}
