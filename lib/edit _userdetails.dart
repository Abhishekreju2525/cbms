import 'package:cbms/studentView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class editUser extends StatefulWidget {
  final String documentId;

  editUser({required this.documentId});

  @override
  State<editUser> createState() => _editUserState();
}

class _editUserState extends State<editUser> {
  bool editedUser = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _roleController = TextEditingController();
  final _docidController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _emailController.dispose();
    _roleController.dispose();

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

    editUser(_nameController.text.trim(), _emailController.text.trim(),
        _roleController.text.trim());

    Navigator.of(context).pop();

    //pop the loading circle
  }

  Future editUser(String name, String email, String role) async {
    final user = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.documentId)
        .update({
      'name': name,
      'email': email,
      'role': role,
    });
    setState(() {
      editedUser = true;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _nameController = new TextEditingController(text: 'Initial value');
  // }

  @override
  Widget build(BuildContext context) {
    CollectionReference studentlist =
        FirebaseFirestore.instance.collection('users');

    if (editedUser == true) {
      editedUser = false;
      return studentView();
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
                          controller: _nameController..text = data['name'],
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Name",
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _emailController..text = data['email'],
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Email",
                          ),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: _roleController..text = data['role'],
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: "Role",
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
