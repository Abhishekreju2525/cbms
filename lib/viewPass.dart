import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class viewPass extends StatefulWidget {
  const viewPass({Key? key}) : super(key: key);

  @override
  State<viewPass> createState() => _viewPassState();
}

class _viewPassState extends State<viewPass> {
  bool status = true;

  disableButton() {
    setState(() {
      status = false;
    });
  }

  enableButton() {
    setState(() {
      status = true;
    });
  }

  verifyPass() {
    if ('aaa' == 'aaa') {
      enableButton();
    } else {
      disableButton();
    }
    return ElevatedButton(
        onPressed: status ? () => () {} : null, child: Text('Renew now'));
  }

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
              child: Column(
        children: [
          QrImage(data: user.uid, size: 120),
          verifyPass(),
        ],
      ))),
    );
  }
}
