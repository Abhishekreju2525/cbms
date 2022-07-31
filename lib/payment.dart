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

  // final newdate = DateFormat("yyyy-MM-dd").format(DateTime.now().add(months:5));
  final newdate = DateTime.now().add(Duration(days: 365));
  late Razorpay _razorpay;
  ValueNotifier<String> amt = ValueNotifier("-");
  TextEditingController amtController = TextEditingController();

  void openCheckout(amount) async {
    print("final amount : $amount");
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
    print("$amt.value");
    final successpasstransactions = <String, dynamic>{
      "email": user.email!,
      "Payment ID": response.paymentId!,
      "Date": cdate,
      "Expiry date": newdate,
      "amount": amt.value.toString()
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
      "amount": amt.value.toString(),
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
    if (paymentDone == true) {
      paymentDone = false;
      return passScreen();
    } else {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                FutureBuilder(
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
                                Text("Choose your boarding point"),
                                DropdownButtonFormField(
                                    hint: Text(_docIDs[0]),
                                    items: _docIDs.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      location = value as String;
                                      // print(location);
                                      // print(_data[0][value]);
                                      amt.value = _data[0][value];
                                      print(amt.value);
                                    }),
                                SizedBox(height: 20),
                                ElevatedButton(
                                    onPressed: () {}, child: Text('Buy')),
                                SizedBox(height: 50),
                                ValueListenableBuilder(
                                    valueListenable: amt,
                                    builder: (BuildContext context,
                                        String amount, Widget? child) {
                                      return Text(
                                        "Total amount : $amount",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      );
                                    }),
                                ElevatedButton(
                                  onPressed: () {
                                    if (amt.value != null) {
                                      setState(() {
                                        int finalamount = int.parse(amt.value);
                                        print(finalamount);
                                        openCheckout(finalamount);
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(9.0),
                                    child: Text('Make payment'),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                )
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
                    }),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
