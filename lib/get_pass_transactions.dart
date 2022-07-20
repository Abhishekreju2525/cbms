import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class getpassHistory extends StatelessWidget {
  final String documentId;

  getpassHistory({required this.documentId});
  @override
  Widget build(BuildContext context) {
    CollectionReference passhistory =
        FirebaseFirestore.instance.collection('pass_transactions');

    return FutureBuilder<DocumentSnapshot>(
        future: passhistory.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListTile(
              title: Text('Email : ${data['email']}'),
              subtitle: Text('Payment ID : ${data['Payment ID']}'),
              trailing: Text('Rs. ${data['amount']}'),
            );
          }
          return Text('Loading...');
        }));
  }
}
