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

                      int count = 0;
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
                          //print(f1);
                          f1.forEach(
                            (elem) async {
                              var s2 = await FirebaseFirestore.instance
                                  .collection("BusQR")
                                  .where("BusNum", isEqualTo: elem.toString())
                                  .get();
                              count++;
                              s2.docs.forEach(
                                (rData) async {
                                  Map<String, dynamic> m3 = rData.data();
                                  Map<String, dynamic> temp = m3["Sdetails"];
                                  String len = temp.length.toString();
                                  //print(temp);
                                  Map<String, dynamic> temp1 =
                                      m3["Sdetails"]["1"];
                                  Map<String, dynamic> temp2 =
                                      m3["Sdetails"][len];

                                  temp1.forEach((key, value) {
                                    setValue1(key.toString());
                                    print(key);
                                  });
                                  temp2.forEach((key, value) {
                                    setValue2(key.toString());
                                    print(key);
                                  });
                                  //st = temp1.keys as String;
                                  //dt = temp2.keys as String;
                                  //print(st);
                                  //print(dt);
                                  //print(m1);
                                  //print(f2);
                                  //print(f2.length);
                                  //print(f2);
                                  //print(temp1.keys);
                                  //print(temp2.keys);
                                  //print(m3);
                                },
                              );
                              if (count == s1.docs.length) {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                await showDialog(
                                  context: ctx,
                                  builder: (cc) {
                                    return AlertDialog(
                                      //scrollable: true,
                                      title: Row(
                                        children: [
                                          Text(sList[index].sName),
                                          Spacer(),
                                          Text(m1["Sid"]),
                                        ],
                                      ),
                                      content: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (cctx, i) {
                                            //print(f1[i]);
                                            //print(st);
                                            //print(dt);
                                            return Card(
                                              color: Colors.blueAccent,
                                              child: ExpansionTile(
                                                key: keyTile,
                                                initiallyExpanded: _isExpanded,
                                                title: Text(f1[i]),
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("SRC: $st"),
                                                      Text("DST: $dt"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          itemCount: f1.length,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          );
                        },
                      );
                      await showDialog(
                        context: ctx,
                        builder: (cc) {
                          return AlertDialog(
                            content: Container(
                              padding: EdgeInsets.all(96),
                              child: CircularProgressIndicator(
                                strokeWidth: 6.0,
                              ),
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
