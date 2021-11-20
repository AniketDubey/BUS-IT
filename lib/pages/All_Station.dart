// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:minoragain/models/DUMMYDATA.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllStation extends StatelessWidget {
  const AllStation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sList.sort((a, b) => a.sName.compareTo(b.sName));
    return Scaffold(
      appBar: AppBar(
        title: Text("All Stations"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/b1.png",
              fit: BoxFit.fill,
            ),
          ),
          ListView.builder(
            itemBuilder: (ctx, index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.ev_station),
                    title: Text(sList[index].sName),
                    subtitle: Text("Metro Station as well"),
                    trailing: Icon(Icons.access_alarm),
                    onTap: () async {
                      var s1 = await FirebaseFirestore.instance
                          .collection("Station")
                          .where("Sname", isEqualTo: sList[index].sName)
                          .get();

                      List<dynamic> f1 = [];

                      s1.docs.forEach((element) {
                        Map<String, dynamic> m1 = element.data();
                        f1 = m1["IncBus"];
                      });

                      showDialog(
                        context: ctx,
                        builder: (cc) {
                          return AlertDialog(
                            //scrollable: true,
                            title: Text(sList[index].sName),
                            content: Padding(
                              padding: EdgeInsets.all(10),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (cctx, i) {
                                  //print(f1[i]);
                                  return Card(
                                    child: ListTile(
                                      title: Text(f1[i]),
                                    ),
                                  );
                                },
                                itemCount: f1.length,
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Text("OK"))
                            ],
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
