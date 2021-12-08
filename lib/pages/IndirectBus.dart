// ignore_for_file: file_names, prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minoragain/models/DUMMYDATA.dart';

class IndirectBus extends StatelessWidget {
  Map<String, String> detailInfo;

  IndirectBus(this.detailInfo);

  List<int> vis = List.filled(50, 0);

  List<int> route = [];

  int check(List<List<int>> vec, int src, int dst) {
    if (vis[src] == 1) {
      return 0;
    }
    vis[src] = 1;

    for (int x in vec[src]) {
      if (x == dst && vis[x] == 0) {
        route.add(x);
        return 1;
      } else if (vis[x] == 0 && check(vec, x, dst) == 1) {
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

  Widget CreateWidget(int index, int Flen) {
    if (index == 0) {
      return Text("SRC: ");
    } else if (index == Flen - 1) {
      return Text("DST: ");
    }
    return Text("$index");
  }

  @override
  Widget build(BuildContext context) {
    String? src = detailInfo["Source"];
    String? dst = detailInfo["Destination"];

    int srci = sInfo.keys.firstWhere((element) => sInfo[element] == src);
    int dsti = sInfo.keys.firstWhere((element) => sInfo[element] == dst);

    List<String?> fList = findList(srci, dsti);

    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          "Indirect Bus List",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: fList.length == 0
            ? Center(
                child: Text("No Buses found!"),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CreateWidget(index, fList.length),
                            Spacer(),
                            AutoSizeText(
                              "${fList[index]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              /* maxFontSize: 18,
                              minFontSize: 14, */
                            ),
                          ],
                        ),
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
