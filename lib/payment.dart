import 'package:cbms/passScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class paymentPage extends StatefulWidget {
  const paymentPage({Key? key}) : super(key: key);

  @override
  State<paymentPage> createState() => _paymentPageState();
}

class _paymentPageState extends State<paymentPage> {
  bool paymentDone = false;
  final user = FirebaseAuth.instance.currentUser!;
  final cdate = DateTime.now();
  final _list = ['Apple', 'orange', 'pineapple'];
  // final newdate = DateFormat("yyyy-MM-dd").format(DateTime.now().add(months:5));
  final newdate = DateTime.now().add(Duration(days: 365));
  late Razorpay _razorpay;

  TextEditingController amtController = TextEditingController();

  void openCheckout(amount) async {
    amount = amount * 100;

    var options = {
      'key': 'rzp_test_dANxeipeG02n9z',
      'amount': amount, //in the smallest currency sub-unit.
      'name': 'test name',
      'prefill': {'contact': '1234567890', 'email': user.email!},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error : e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final user = FirebaseAuth.instance.currentUser!;
    Fluttertoast.showToast(
        msg: "Payment successful" + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);

    final successpasstransactions = <String, dynamic>{
      "email": user.email!,
      "Payment ID": response.paymentId!,
      "Date": cdate,
      "Expiry date": newdate,
      "amount": amtController.text
    };

    FirebaseFirestore.instance
        .collection("pass_transactions")
        .doc()
        .set(successpasstransactions)
        .onError((e, _) => print("Error writing document: $e"));

    FirebaseFirestore.instance
        .collection("record_stats")
        .doc('totalPass')
        .update({"total": FieldValue.increment(1)}).catchError((e) {
      print(e);
    });
    int? total12;
    FirebaseFirestore.instance
        .collection("record_stats")
        .doc("totalPass")
        .get()
        .then((ds) {
      final data = ds.data() as Map<String, dynamic>;
      print(data);
      total12 = data['total'];
      print("total records: $total12");

      return total12;
    });

    final passStatusData = <String, dynamic>{
      "email": user.email!,
      "Payment ID": response.paymentId!,
      "purchase date": cdate,
      "Expiry": newdate,
      "amount": amtController.text,
      "status": "true",
      // "serial": serialno,
    };

    FirebaseFirestore.instance
        .collection("pass_data")
        .doc(user.uid)
        .update(passStatusData)
        .onError((e, _) => print("Error writing document: $e"));
    setState(() {
      paymentDone = true;
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment fail" + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "external wallet" + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  final List<String> _docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('fees')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              _docIDs.add(document.reference.id);
            }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  String? location;
  @override
  Widget build(BuildContext context) {
    if (paymentDone == true) {
      paymentDone = false;
      return passScreen();
    } else {
      return Scaffold(
          body: Center(
        child: Container(
            child: Center(
                child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hi everyone'),
              FutureBuilder(
                  future: getDocId(),
                  builder: ((context, snapshot) {
                    return Container(
                      child: DropdownButtonFormField(
                          hint: Text("Choose your pickup/drop point "),
                          items: _docIDs.map((e) {
                            return DropdownMenuItem(value: e, child: Text(e));
                          }).toList(),
                          onChanged: (value) {
                            print(value);
                            location = value as String?;
                            print("location is " + location!);
                          }),
                    );
                  }))
            ],
          ),
        ))),
      )

          // if we got our data

          );

      // Displaying LoadingSpinner to indicate waiting state

    }
  }
}
