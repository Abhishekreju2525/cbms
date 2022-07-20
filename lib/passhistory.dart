import 'package:cbms/get_pass_transactions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class passHistory extends StatefulWidget {
  const passHistory({Key? key}) : super(key: key);

  @override
  State<passHistory> createState() => _passHistoryState();
}

class _passHistoryState extends State<passHistory> {
  final List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('pass_transactions')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getDocId(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context, index) {
                        return Card(
                            color: Color.fromARGB(255, 196, 220, 255),
                            child: getpassHistory(documentId: docIDs[index]));
                      },
                    );
                  })),
        ],
      ),
    );
  }
}
