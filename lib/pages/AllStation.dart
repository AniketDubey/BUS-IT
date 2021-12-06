// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:minoragain/models/DUMMYDATA.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllStation extends StatefulWidget {
  const AllStation({Key? key}) : super(key: key);

  @override
  State<AllStation> createState() => _AllStationState();
}

class _AllStationState extends State<AllStation> {
  bool _isExpanded = false;

  String? st, dt;
  UniqueKey? keyTile;

  void expandTile() {
    setState(() {
      _isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      _isExpanded = false;
      keyTile = UniqueKey();
    });
  }

  void setValue1(String val) {
    setState(() {
      st = val;
    });
  }

  void setValue2(String val) {
    setState(() {
      dt = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    sList.sort((a, b) => a.sName.compareTo(b.sName));
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text(
          "All Stations",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Stack(
        children: [
          /*Positioned.fill(
            child: Image.asset(
              "assets/b1.png",
              fit: BoxFit.fill,
            ),
          ),*/
          ListView.builder(
            itemBuilder: (ctx, index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.bus_alert),
                    title: Text(sList[index].sName),
                    subtitle: Text("Metro Station as well"),
                    trailing: Icon(Icons.info),
                    onTap: () async {
                      var s1 = await FirebaseFirestore.instance
                          .collection("Station")
                          .where("Sname", isEqualTo: sList[index].sName)
                          .get();

                      List<dynamic> f1 = [];
                      Map<String, dynamic> m1 = {};

                      s1.docs.forEach(
                        (element) async {
                          m1 = element.data();
                          //print(m1);
                          //f2.add(m1);
                          Map<String, dynamic> mm2 = m1["IncBus"];
                          mm2.forEach(
                            (key, value) {
                              f1.add(key);
                            },
                          );
                        },
                      );
                      await showDialog(
                        context: ctx,
                        builder: (cc) {
                          return AlertDialog(
                            content: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (cptx, i) {
                                return Card(
                                  child: Text(
                                    f1[i],
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                              itemCount: f1.length,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
            itemCount: sList.length,
          ),
        ],
      ),
    );
  }
}
