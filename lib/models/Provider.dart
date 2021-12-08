// ignore_for_file: file_names, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BList with ChangeNotifier {
  List<dynamic> _l4 = [];

  List<dynamic> get l4 {
    return _l4;
  }

  Map<String, dynamic>? _dataSourceMap = {};

  Map<String, dynamic>? get dataSourceMap {
    return _dataSourceMap;
  }

  Map<String, dynamic>? _dataDestinationMap = {};

  Map<String, dynamic>? get dataDestinationMap {
    return _dataDestinationMap;
  }

  int _PasCount = 0; // need to change this ahead

  String? _Id;

  String get Id {
    return _Id as String;
  }

  String? _sID;

  String get sID {
    return _sID as String;
  }

  int get PasCount {
    return _PasCount;
  }

  int _sPasCount = 0;

  int get sPasCount {
    return _sPasCount;
  }

  void setVal(int nval) => _PasCount = nval;

  Future<void> fetchData(_details) async {
    List<dynamic> l1 = [];
    List<dynamic> l2 = [];
    List<dynamic> l3 = [];

    try {
      var s1 = await FirebaseFirestore.instance
          .collection("Station")
          .where("Sname", isEqualTo: "${_details["Source"]}")
          .get();

      s1.docs.forEach((element) {
        Map<String, dynamic> m1 = element.data();
        Map<String, dynamic> mm1 = m1["IncBus"];
        mm1.forEach((key, value) {
          l1.add(key);
        });
      });
    } catch (error) {
      print(error);
    }

    try {
      var s2 = await FirebaseFirestore.instance
          .collection("Station")
          .where("Sname", isEqualTo: "${_details["Destination"]}")
          .get();

      s2.docs.forEach((element) {
        Map<String, dynamic> m2 = element.data();
        Map<String, dynamic> mm2 = m2["IncBus"];
        mm2.forEach((key, value) {
          l2.add(key);
        });
      });

      l1.forEach((ele1) {
        if (l2.contains(ele1)) {
          l3.add(ele1);
        }
      });

      l3.forEach(
        (element) async {
          var s3 = await FirebaseFirestore.instance
              .collection("BusQR")
              .where("BusNum", isEqualTo: element)
              .get();
          s3.docs.forEach(
            (elems) {
              Map<String, dynamic> m3 = elems.data();
              Map<String, dynamic> temp = m3["Sdetails"];

              var index1 = temp.keys.firstWhere((ele) {
                Map<String, dynamic> temp2 = temp[ele];
                return (temp2.containsKey("${_details["Source"]}"));
              });

              var index2 = temp.keys.firstWhere((ele) {
                Map<String, dynamic> temp2 = temp[ele];
                return (temp2.containsKey("${_details["Destination"]}"));
              });

              int a = int.parse(index1);
              int b = int.parse(index2);

              if ((b - a) > 0) {
                _l4.add(m3);
                notifyListeners();
              }
            },
          );
        },
      );
    } catch (error) {
      print(error);
    }
  }

  Future<void> screenChange() async {
    l4.clear();
  }

  Future<int> getPasLog(String busNo) async {
    try {
      QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore
          .instance
          .collection("BusQR")
          .where("BusNum", isEqualTo: busNo)
          .get();
      value.docs.forEach((element) {
        Map<String, dynamic> Finfo = element.data();
        _PasCount = Finfo["PasLog"];
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
    return _PasCount;
  }

  Future<int> getsPasLog(String destination, String busNo) async {
    try {
      QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore
          .instance
          .collection("Station")
          .where("Sname", isEqualTo: destination)
          .get();
      value.docs.forEach((element) {
        Map<String, dynamic> Finfo = element.data();
        //print(Finfo);
        Map<String, dynamic> sDMap = Finfo["IncBus"];
        _sPasCount = sDMap[busNo];
        //_sPasCount = Finfo["PasLog"];
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
    return _sPasCount;
  }

  Future<String?> getID(String busNo) async {
    try {
      QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore
          .instance
          .collection("BusQR")
          .where("BusNum", isEqualTo: busNo)
          .get();

      value.docs.forEach((element) {
        //print("provider se ${element.reference.id}");
        _Id = element.reference.id;

        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
    return _Id;
  }

  Future<String?> getSID(String destination) async {
    try {
      QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore
          .instance
          .collection("Station")
          .where("Sname", isEqualTo: destination)
          .get();

      value.docs.forEach((element) {
        //print("provider se ${element.reference.id}");
        _sID = element.reference.id;
        print("station id provider se $_sID");
        notifyListeners();
      });
    } catch (error) {
      print(error);
    }
    return _sID;
  }

  Future<void> changeData(String BID, int PasData, String sId, int sPasLog,
      String busNo, int to_board) async {
    try {
      await FirebaseFirestore.instance.collection("BusQR").doc(BID).update({
        "PasLog": PasData + to_board,
      });

      var data =
          await FirebaseFirestore.instance.collection("Station").doc(sId).get();

      var ndata = data.data();
      ndata!["IncBus"][busNo] = sPasLog + to_board;

      //print(ndata["IncBus"][busNo]);

      //String fId = "r4xqAhEvOnmdeSuS9ahD";

      await FirebaseFirestore.instance.collection("Station").doc(sId).update({
        "IncBus": ndata["IncBus"],
      });
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> analyticsData(Map<String, String> rData) async {
    try {
      String src = rData["Source"]!;
      String dst = rData["Destination"]!;
      var sdata = await FirebaseFirestore.instance
          .collection("Analytics")
          .doc("Source")
          .get();
      var sinfo = sdata.data();

      if (sinfo!.containsKey(src)) {
        sinfo[src] = sinfo[src] + 1;
      } else {
        sinfo[src] = 1;
      }

      var ddata = await FirebaseFirestore.instance
          .collection("Analytics")
          .doc("Destination")
          .get();
      var dinfo = ddata.data();

      if (dinfo!.containsKey(dst)) {
        dinfo[dst] = dinfo[dst] + 1;
      } else {
        dinfo[dst] = 1;
      }

      //print(sinfo);
      //print(dinfo);

      await FirebaseFirestore.instance
          .collection("Analytics")
          .doc("Source")
          .set(sinfo);
      await FirebaseFirestore.instance
          .collection("Analytics")
          .doc("Destination")
          .set(dinfo);
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchSourceAnalytics() async {
    var sdata = await FirebaseFirestore.instance
        .collection("Analytics")
        .doc("Source")
        .get();

    _dataSourceMap = sdata.data();
    notifyListeners();
    //print("provider se $_dataSourceMap");
  }

  Future<void> fetchDestinationAnalytics() async {
    var ddata = await FirebaseFirestore.instance
        .collection("Analytics")
        .doc("Destination")
        .get();

    _dataDestinationMap = ddata.data();
    notifyListeners();
    //print("provider se $_dataDestinationMap");
  }
}
