// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:minoragain/models/DUMMYDATA.dart';

class AllStation extends StatelessWidget {
  const AllStation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Stations"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(),
          );
        },
        itemCount: sList.length,
      ),
    );
  }
}
