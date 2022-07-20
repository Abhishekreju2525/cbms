import 'package:cbms/studentView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class editProfile extends StatefulWidget {
  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  bool editedUser = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _emailController.dispose();

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

    editUser(_nameController.text.trim());

    Navigator.of(context).pop();

    //pop the loading circle
  }

  Future editUser(String name) async {
    final user = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'name': name,
    });
    setState(() {
      editedUser = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    CollectionReference studentlist =
        FirebaseFirestore.instance.collection('users');

    if (editedUser == true) {
      editedUser = false;
      return editProfile();
    } else {
      return Material(
        child: SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
              future: studentlist.doc(user.uid).get(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Container(
                          child: Center(
                            child: Text(
                              'Update your details',
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
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
                            enabled: false,
                            controller: _emailController..text = data['email'],
                            decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: "Email",
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
                    ),
                  );
                }
                return Text('Loading...');
              })),
        ),
      );
    }
  }
}
