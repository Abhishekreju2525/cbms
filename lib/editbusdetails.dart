import 'package:cbms/busView.dart';
import 'package:cbms/studentView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class editBus extends StatefulWidget {
  final String documentId;

  editBus({required this.documentId});

  @override
  State<editBus> createState() => _editBusState();
}

class _editBusState extends State<editBus> {
  bool editedBus = false;
  final _regnumController = TextEditingController();
  final _vehnumController = TextEditingController();
  final _routeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _regnumController.dispose();
    _vehnumController.dispose();
    _routeController.dispose();

    // _confirmpasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    //Loading Circle
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });

    final user = FirebaseAuth.instance.currentUser!;

    editBus(_regnumController.text.trim(), _vehnumController.text.trim(),
        _routeController.text.trim());

    Navigator.of(context).pop();

    //pop the loading circle
  }

  Future editBus(
      String registration, String route, String vehiclenumber) async {
    final user = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection('bus')
        .doc(widget.documentId)
        .update({
      'registration': registration,
      'route': route,
      'vehicle number': vehiclenumber,
    });
    setState(() {
      editedBus = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference studentlist =
        FirebaseFirestore.instance.collection('bus');

    if (editedBus == true) {
      editedBus = false;
      return busView();
    } else {
      return Material(
        child: SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
              future: studentlist.doc(widget.documentId).get(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    children: [
                      Container(
                        child: TextFormField(
                          controller: _regnumController
                            ..text = data['registration'],
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Registration",
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _vehnumController..text = data['route'],
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Vehicle",
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _routeController
                            ..text = data['vehicle number'],
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Route",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                          ),
                          onPressed: signUp,
                          child: const Text('Update'),
                        ),
                      ),
                    ],
                  );
                }
                return Text('Loading...');
              })),
        ),
      );
    }
  }
}
