// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Payment Gateway"),
      ),
      // ignore: prefer_const_constructors
      body: Center(
        child: Text("Thank you"),
      ),
    );
  }
}
