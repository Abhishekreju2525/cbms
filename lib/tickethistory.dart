import 'package:cbms/get_ticket_transactions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class ticketHistory extends StatefulWidget {
  const ticketHistory({Key? key}) : super(key: key);

  @override
  State<ticketHistory> createState() => _ticketHistoryState();
}

class _ticketHistoryState extends State<ticketHistory> {
  final List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('ticket_transactions')
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
                            color: Color.fromARGB(255, 255, 208, 212),
                            child: getTicketHistory(documentId: docIDs[index]));
                      },
                    );
                  })),
        ],
      ),
    );
  }
}
