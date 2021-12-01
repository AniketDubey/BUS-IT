// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:minoragain/models/DUMMYDATA.dart';
import "dart:io";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graph_collection/graph.dart';
import 'dart:collection';

class IndirectBus extends StatelessWidget {
  //const IndirectBus({Key? key}) : super(key: key);

  Map<String, String> detailInfo;

  IndirectBus(this.detailInfo);

  /*void findname(String? str) async {
    var s1 = await FirebaseFirestore.instance
        .collection("Station")
        .where("Sname", isEqualTo: str)
        .get();

    String? data;

    s1.docs.forEach((element) {
      Map<String, dynamic> m1 = element.data();
      data = m1["Sid"];
    });

    print(data); 

  }*/

  List<int> vis = List.filled(50, 0);

  List<int> route = [];

  int check(List<List<int>> vec, int src, int dst) {
    if (vis[src] == 1) {
      return 0;
    }
    vis[src] = 1;
    //stdout.write("$src ->");
    for (int x in vec[src]) {
      if (x == dst && vis[x] == 0) {
        //print("upar se $x");
        route.add(x);
        return 1;
      } else if (vis[x] == 0 && check(vec, x, dst) == 1) {
        //print("yahan se $x");
        route.add(x);
        return 1;
      }
    }
    return 0;
  }

  List<String?> findList(int srci, int dsti) {
    List<String?> _toReturn = [];

    if (check(vec, srci, dsti) == 1) {
      route.add(srci);
    }

    route.forEach((element) {
      _toReturn.add(sInfo[element]);
    });

    List<String?> _fReturn = List.from(_toReturn.reversed);
    return _fReturn;
  }

  @override
  Widget build(BuildContext context) {
    //print(detailInfo);

    String? src = detailInfo["Source"];
    String? dst = detailInfo["Destination"];
    //print(vec[24]);

    int srci = sInfo.keys.firstWhere((element) => sInfo[element] == src);
    int dsti = sInfo.keys.firstWhere((element) => sInfo[element] == dst);

    List<String?> fList = findList(srci, dsti);

    //print(fList);

    return Scaffold(
      appBar: AppBar(
        title: Text("Indirect Bus List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  "${fList[index]}",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            );
          },
          itemCount: fList.length,
        ),
      ),
    );
  }
}
