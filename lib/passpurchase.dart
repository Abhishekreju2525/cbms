import 'dart:math';

import 'package:cbms/getfeelist.dart';
import 'package:cbms/getstudentlist.dart';
import 'package:cbms/getstudentlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class passPurchase extends StatefulWidget {
  const passPurchase({Key? key}) : super(key: key);

  @override
  State<passPurchase> createState() => _passPurchaseState();
}

class _passPurchaseState extends State<passPurchase> {
  final List<String> _docIDs = [];
  final List<String> _fees = [];

  String? location;

  Future<List<Map<dynamic, dynamic>>> getDocId() async {
    await FirebaseFirestore.instance
        .collection('fees')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              _docIDs.add(document.reference.id);
              _fees.add(document.data()['fees']);
            }));
    List<DocumentSnapshot> _templist;
    List<Map<dynamic, dynamic>> list = [];
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("feeamount");
    QuerySnapshot collectionSnapshot = await collectionRef.get();

    _templist = collectionSnapshot.docs.toList();

    list = _templist.map((DocumentSnapshot docSnapshot) {
      return docSnapshot.data() as Map<dynamic, dynamic>; // <--- Typecast this.
    }).toList();

    return list;
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
                    if (snapshot.connectionState == ConnectionState.done) {
                      print(snapshot.data);
                      final _data =
                          snapshot.data as List<Map<dynamic, dynamic>>;
                      final _feedata = _data as List;

                      // If we got an error
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occurred',
                            style: TextStyle(fontSize: 18),
                          ),
                        );

                        // if we got our data
                      } else if (snapshot.hasData) {
                        return Container(
                          child: Column(
                            children: [
                              DropdownButtonFormField(
                                  hint: Text("Choose your Boarding point"),
                                  items: _docIDs.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    location = value as String;
                                    print(location);
                                    print(_data[0][value]);
                                  }),
                              ElevatedButton(
                                  onPressed: () {}, child: Text('Buy'))
                            ],
                          ),
                        );
                      } else {
                        return Text('Error page ');
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
        ],
      ),
    );
  }
}
