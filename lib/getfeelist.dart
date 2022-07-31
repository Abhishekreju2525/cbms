import 'package:cbms/edit%20_userdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class getFeeList extends StatelessWidget {
  final String documentId;

  getFeeList({required this.documentId});
  @override
  Widget build(BuildContext context) {
    CollectionReference feelist = FirebaseFirestore.instance.collection('fees');

    return FutureBuilder<DocumentSnapshot>(
        future: feelist.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            print("${data['fees']}");
            return Scaffold(
              body: Container(
                child: Text("${data['fees']}"),
              ),
            );
          }
          return Center(
            child: LinearProgressIndicator(
              color: Color.fromARGB(255, 75, 75, 75),
              backgroundColor: Colors.grey,
            ),
          );
        }));
  }
}
