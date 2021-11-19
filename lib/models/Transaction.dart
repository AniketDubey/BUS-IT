// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Transaction {
  DateTime? date;
  double? amount;
  Map<String, String>? tdetails = {"Source": "", "Destination": ""};
  Transaction(
      {required this.amount, required this.date, required this.tdetails});
}
