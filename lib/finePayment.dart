import 'package:cbms/addDriver.dart';
import 'package:cbms/getdriverlist.dart';
import 'package:cbms/getfinelist.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class fineScreen extends StatefulWidget {
  const fineScreen({Key? key}) : super(key: key);

  @override
  State<fineScreen> createState() => _fineScreenState();
}

class _fineScreenState extends State<fineScreen> {
  final List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('fine')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FInes & dues"),
        backgroundColor: Color.fromARGB(255, 120, 170, 211),
      ),
      body: Column(
        children: [
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
                          child: getFineList(documentId: docIDs[index]));
                    },
                  );
                }),
          )),
        ],
      ),
    );
  }
}
