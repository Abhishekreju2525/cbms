import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class paymentPage extends StatefulWidget {
  const paymentPage({Key? key}) : super(key: key);

  @override
  State<paymentPage> createState() => _paymentPageState();
}

class _paymentPageState extends State<paymentPage> {
  final user = FirebaseAuth.instance.currentUser!;
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
            // Image.network(
            //   'data:image/jpeg;base64,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',
            //   height: 100,
            //   width: 300,
            // ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Welcome to payment page',
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
