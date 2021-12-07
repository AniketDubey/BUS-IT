// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AfterScan extends StatefulWidget {
  @override
  State<AfterScan> createState() => _AfterScanState();
}

class _AfterScanState extends State<AfterScan> {
  late Razorpay _razorpay;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose

    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Information"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
          ),
          TextButton(
            onPressed: () {
              var options = {
                'key': "rzp_test_LAi8gffdffQaA2",
                'amount': (int.parse(_controller.text) * 100)
                    .toString(), //in the smallest currency sub-unit.
                'name': 'Aniket Dubey Minor',
                'description': 'Demo',
                'timeout': 300, // in seconds
                'prefill': {
                  'contact': '0123456798',
                  'email': 'aniket.dubey0206@gmail.com'
                }
              };

              _razorpay.open(options);
            },
            child: Text("Pay"),
          ),
        ],
      ),
    );
  }
}
