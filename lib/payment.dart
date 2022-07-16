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
  final user = FirebaseAuth.instance.currentUser!;
  final cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  // final newdate = DateFormat("yyyy-MM-dd").format(DateTime.now().add(months:5));
  final newdate =
      DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 365)));
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
    Fluttertoast.showToast(
        msg: "Payment successful" + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);

    final successpasstransactions = <String, String>{
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 58, 89),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Buy bus pass here',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                cursorColor: Colors.white,
                autofocus: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Enter amount to be paid',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15)),
                controller: amtController,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (amtController.text.toString().isNotEmpty) {
                  setState(() {
                    int amount = int.parse(amtController.text.toString());
                    openCheckout(amount);
                  });
                }
              },
              child: Padding(
                padding: EdgeInsets.all(9.0),
                child: Text('Make payment'),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
