// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class AfterScan extends StatelessWidget {
  //const AfterScan({Key? key}) : super(key: key);

  var scanInfo;
  AfterScan(this.scanInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Information"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Bus Number"),
                    Spacer(),
                    Text(
                      scanInfo["BusNum"],
                    ),
                    Spacer(),
                    Icon(Icons.info),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text("Passenger"),
                    Spacer(),
                    Text(
                      scanInfo["PassLog"],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
