import 'package:cbms/BottomNavigationBar.dart';
import 'package:cbms/adminDashboard.dart';
import 'package:cbms/dashboardScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'viewPass.dart';

class ticketScreen extends StatefulWidget {
  @override
  State<ticketScreen> createState() => _ticketScreenState();
}

final user = FirebaseAuth.instance.currentUser!;
final user1 = FirebaseAuth.instance.currentUser!;

class _ticketScreenState extends State<ticketScreen> {
  var ticketpaymentDone;
  TextEditingController amtController = TextEditingController();
  final cdate = DateTime.now();
  final curDate = DateTime.now();
  DateTime? purchaseDate;
  final user = FirebaseAuth.instance.currentUser!;
  final DocumentReference<Map<String, dynamic>> _docRef =
      FirebaseFirestore.instance.collection('ticket_data').doc(user1.uid);

  // final newdate = DateFormat("yyyy-MM-dd").format(DateTime.now().add(months:5));

  late Razorpay _razorpay;

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

  Future<dynamic> getData() {
    final user = FirebaseAuth.instance.currentUser!;
    final DocumentReference<Map<String, dynamic>> _docRef =
        FirebaseFirestore.instance.collection('ticket_data').doc(user.uid);
    print("user uid first is :::" + user.uid);
    return Future.delayed(Duration(seconds: 0), () async {
      DocumentSnapshot docSnap = await _docRef.get();

      // Get data from docs and convert map to List
      final snapData = docSnap.data() as Map<String, dynamic>;

      // print('role : $role');
      print("purchase date ::: $purchaseDate");
      print("current date :::$curDate");
      // print(snapData);
      return snapData;
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final user = FirebaseAuth.instance.currentUser!;
    Fluttertoast.showToast(
        msg: "Payment successful" + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);

    final successtickettransactions = <String, dynamic>{
      "email": user.email!,
      "Payment ID": response.paymentId!,
      "Date": cdate,
      "amount": amtController.text
    };

    FirebaseFirestore.instance
        .collection("ticket_transactions")
        .doc()
        .set(successtickettransactions)
        .onError((e, _) => print("Error writing document: $e"));

    FirebaseFirestore.instance
        .collection("record_stats")
        .doc('totalticket')
        .set({"total": FieldValue.increment(1)}).catchError((e) {
      print(e);
    });
    int? total12;
    FirebaseFirestore.instance
        .collection("record_stats")
        .doc("totalticket")
        .get()
        .then((ds) {
      final data = ds.data() as Map<String, dynamic>;
      print(data);
      total12 = data['total'];
      print("total ticket records: $total12");

      return total12;
    });

    final ticketStatusData = <String, dynamic>{
      "email": user.email!,
      "Payment ID": response.paymentId!,
      "purchase date": cdate,
      "amount": amtController.text,
      "status": "true",
      // "serial": serialno,
    };
    print(user.uid);
    FirebaseFirestore.instance
        .collection("ticket_data")
        .doc(user.uid)
        .set(ticketStatusData)
        .onError((e, _) => print("Error writing document: $e"));
    setState(() {
      ticketpaymentDone = true;
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    final user = FirebaseAuth.instance.currentUser!;
    Fluttertoast.showToast(
        msg: "Payment fail" + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    final user = FirebaseAuth.instance.currentUser!;
    Fluttertoast.showToast(
        msg: "external wallet" + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    if (ticketpaymentDone == true) {
      ticketpaymentDone = false;
      return ticketScreen();
    }
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          builder: (ctx, snapshot) {
            // Checking if future is resolved or not
            if (snapshot.connectionState == ConnectionState.done) {
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
                final data = snapshot.data as Map<String, dynamic>;

                print("Snapshot data ::: $data");
                if (data['status'] == "true") {
                  return Scaffold(
                    backgroundColor: Color.fromARGB(255, 248, 248, 248),
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
                            'Buy bus ticket here',
                            style: TextStyle(
                                color: Color.fromARGB(255, 53, 53, 53),
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              cursorColor: Color.fromARGB(255, 43, 43, 43),
                              autofocus: false,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 139, 6, 6)),
                              decoration: InputDecoration(
                                  labelText: 'Enter amount to be paid',
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 54, 54, 54),
                                    fontSize: 15,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  errorStyle: TextStyle(
                                      color: Color.fromARGB(255, 177, 0, 0),
                                      fontSize: 15)),
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
                                  int amount =
                                      int.parse(amtController.text.toString());
                                  openCheckout(amount);
                                });
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(9.0),
                              child: Text('Make payment'),
                            ),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Active ticket',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Card(
                                          color: Colors.amber,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Amount : " +
                                                      data['amount']),
                                                  SizedBox(height: 10),
                                                  Text("Ticket ID : " +
                                                      data['Payment ID']),
                                                  SizedBox(height: 10),
                                                  Text("Booking date : " +
                                                      purchaseDate.toString()),
                                                ]),
                                          ),
                                        ),
                                        QrImage(data: user.uid, size: 70),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: Color.fromARGB(255, 248, 248, 248),
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
                            'Buy bus ticket here',
                            style: TextStyle(
                                color: Color.fromARGB(255, 53, 53, 53),
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              cursorColor: Color.fromARGB(255, 43, 43, 43),
                              autofocus: false,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 139, 6, 6)),
                              decoration: InputDecoration(
                                  labelText: 'Enter amount to be paid',
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 54, 54, 54),
                                    fontSize: 15,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  errorStyle: TextStyle(
                                      color: Color.fromARGB(255, 177, 0, 0),
                                      fontSize: 15)),
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
                                  int amount =
                                      int.parse(amtController.text.toString());
                                  openCheckout(amount);
                                });
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(9.0),
                              child: Text('Make payment'),
                            ),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }
            }

            // Displaying LoadingSpinner to indicate waiting state
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getData(),
        ),
      ),
    );
  }
}
