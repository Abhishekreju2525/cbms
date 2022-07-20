import 'package:cbms/editdriverdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class getDriverList extends StatefulWidget {
  final String documentId;

  getDriverList({required this.documentId});

  @override
  State<getDriverList> createState() => _getDriverListState();
}

class _getDriverListState extends State<getDriverList> {
  @override
  Widget build(BuildContext context) {
    CollectionReference driverList =
        FirebaseFirestore.instance.collection('driver');

    return FutureBuilder<DocumentSnapshot>(
        future: driverList.doc(widget.documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListTile(
              title: Text('Name : ${data['name']}'),
              subtitle: Text('Phone : ${data['mobile']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => editDriver(
                                documentId: widget.documentId,
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
