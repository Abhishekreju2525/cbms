import 'package:cbms/editbusdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class getBusList extends StatefulWidget {
  final String documentId;

  getBusList({required this.documentId});

  @override
  State<getBusList> createState() => _getBusListState();
}

class _getBusListState extends State<getBusList> {
  @override
  Widget build(BuildContext context) {
    CollectionReference busList = FirebaseFirestore.instance.collection('bus');

    return FutureBuilder<DocumentSnapshot>(
        future: busList.doc(widget.documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListTile(
              leading: Text(
                ' ${data['vehicle number']}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              title: Text('${data['registration']}'),
              subtitle: Text(
                'Route : ${data['route']}',
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => editBus(
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
