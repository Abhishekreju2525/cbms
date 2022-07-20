import 'package:cbms/driverView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class editDriver extends StatefulWidget {
  final String documentId;

  editDriver({required this.documentId});

  @override
  State<editDriver> createState() => _editDriverState();
}

class _editDriverState extends State<editDriver> {
  bool editedDriver = false;
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _mobileController.dispose();

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

    editDriver(_nameController.text.trim(), _mobileController.text.trim());

    Navigator.of(context).pop();

    //pop the loading circle
  }

  Future editDriver(String name, String mobile) async {
    final user = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection('driver')
        .doc(widget.documentId)
        .update({
      'name': name,
      'mobile': mobile,
    });
    setState(() {
      editedDriver = true;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _nameController = new TextEditingController(text: 'Initial value');
  // }

  @override
  Widget build(BuildContext context) {
    CollectionReference driverlist =
        FirebaseFirestore.instance.collection('driver');

    if (editedDriver == true) {
      editedDriver = false;
      return driverView();
    } else {
      return Material(
        child: SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
              future: driverlist.doc(widget.documentId).get(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    children: [
                      Container(
                        child: TextFormField(
                          controller: _nameController..text = data['name'],
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Name",
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _mobileController..text = data['mobile'],
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Mobile",
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
