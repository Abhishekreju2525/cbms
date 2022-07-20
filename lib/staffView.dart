import 'package:cbms/getstafflist.dart';
import 'package:cbms/getstudentlist.dart';
import 'package:cbms/getstudentlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class staffView extends StatefulWidget {
  const staffView({Key? key}) : super(key: key);

  @override
  State<staffView> createState() => _staffViewState();
}

class _staffViewState extends State<staffView> {
  final List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where("category", isEqualTo: "staff")
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
          Expanded(
              child: FutureBuilder(
                  future: getDocId(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Card(
                            color: Color.fromARGB(255, 202, 223, 255),
                            child: getStaffList(documentId: docIDs[index]));
                      },
                    );
                  })),
        ],
      ),
    );
  }
}
