import 'package:cbms/edit%20_userdetails.dart';
import 'package:cbms/editbusdetails.dart';
import 'package:cbms/editdriverdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class getStaffList extends StatelessWidget {
  final String documentId;

  getStaffList({required this.documentId});
  @override
  Widget build(BuildContext context) {
    CollectionReference stafflist =
        FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: stafflist.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListTile(
              title: Text('Email : ${data['email']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => editUser(
                                documentId: documentId,
                              )));
                },
                child: Text('Edit'),
              ),
            );
          }
          return Text('Loading...');
        }));
  }
}
