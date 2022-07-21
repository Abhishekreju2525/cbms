import 'package:cbms/editbusdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class getFineList extends StatefulWidget {
  final String documentId;

  getFineList({required this.documentId});

  @override
  State<getFineList> createState() => _getFineListState();
}

class _getFineListState extends State<getFineList> {
  @override
  Widget build(BuildContext context) {
    CollectionReference fineList =
        FirebaseFirestore.instance.collection('fine');

    return FutureBuilder<DocumentSnapshot>(
        future: fineList.doc(widget.documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListTile(
              leading: Text(
                ' Rs. ${data['amount']}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              title: Text('${data['email']}'),
              subtitle: Text('${data['status']}'),
            );
          }
          return Text('Loading...');
        }));
  }
}
