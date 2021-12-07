// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    String? src = detailInfo["Source"];
    String? dst = detailInfo["Destination"];

    int srci = sInfo.keys.firstWhere((element) => sInfo[element] == src);
    int dsti = sInfo.keys.firstWhere((element) => sInfo[element] == dst);

    List<String?> fList = findList(srci, dsti);

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
