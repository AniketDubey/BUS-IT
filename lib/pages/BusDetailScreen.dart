// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:minoragain/models/Provider.dart';
import 'package:minoragain/pages/IndirectBus.dart';
import 'package:minoragain/pages/Scanqr.dart';
import 'package:provider/provider.dart';

class BusDetailScreen extends StatefulWidget {
  Map<String, String> detailInfo;
  BusDetailScreen(this.detailInfo);

  @override
  _BusDetailScreenState createState() => _BusDetailScreenState();
}

class _BusDetailScreenState extends State<BusDetailScreen> {
  bool _isLoading = true;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _controller = TextEditingController();

  void submitData() async {
    await Provider.of<BList>(context, listen: false)
        .fetchData(widget.detailInfo);
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      _isLoading = false;
    });
  }

  bool _isExpanded = false;
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

  Future<void> _updateData(
      String busNo, String destination, int to_board) async {
    String? Bid = await Provider.of<BList>(context, listen: false).getID(busNo);
    String? sID =
        await Provider.of<BList>(context, listen: false).getSID(destination);

    int? sPasLog = await Provider.of<BList>(context, listen: false)
        .getsPasLog(destination, busNo);

    int? PasCount =
        await Provider.of<BList>(context, listen: false).getPasLog(busNo);

    if (Bid != null && sID != null) {
      await Provider.of<BList>(context, listen: false)
          .changeData(Bid, PasCount, sID, sPasLog, busNo, to_board);
    }
  }

  @override
  void initState() {
    submitData();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _showScaffold(BuildContext context, String data) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(data),
      ),
    );
  }

  Widget InfoGiver(String s1, var s2, BuildContext ctx) {
    s2 = s2.toString();
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(ctx).size.width * 0.3,
          child: AutoSizeText(
            s1,
            textAlign: TextAlign.left,
            maxLines: 2,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(ctx).size.width * 0.3,
          child: AutoSizeText(
            s2,
            textAlign: TextAlign.right,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget TopInfoGiver(String s1, var s2, BuildContext ctx) {
    s2 = s2.toString();
    return Row(
      children: [
        Text(
          s1,
          maxLines: 2,
        ),
        Spacer(),
        Text(
          s2,
          maxLines: 2,
        ),
      ],
    );
  }

  List<int> _fareInfo = [];
  List<double> _fareTotal = [];
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () async {
        Provider.of<BList>(context, listen: false).screenChange();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.deepOrangeAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: AutoSizeText(
                  "${widget.detailInfo["Source"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 22),
                  maxLines: 2,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(Icons.arrow_forward),
              SizedBox(
                width: 8,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: AutoSizeText(
                  "${widget.detailInfo["Destination"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 22),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Consumer<BList>(
              builder: (ctx, data, ch) {
                return _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 6,
                        ),
                      )
                    : data.l4.length == 0
                        ? AlertDialog(
                            scrollable: true,
                            title: Text("Oops !"),
                            content: Text("No bus for the route"),
                            actions: [
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              IndirectBus(widget.detailInfo),
                                        ),
                                      );
                                    },
                                    child: Text("Alternate Routes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("BACK"),
                                  ),
                                ],
                              )
                            ],
                          )
                        : ListView.builder(
                            itemBuilder: (ctx, index) {
                              int _busFare = 0;
                              List<int> sdata = [];
                              Map<String, dynamic> temp = data.l4[index];
                              Map<String, dynamic> mp = temp["Sdetails"];
                              mp.forEach((key, value) {
                                Map<String, dynamic> newmp = value;
                                newmp.forEach((key, value) {
                                  if (key == widget.detailInfo["Source"]) {
                                    List<dynamic> _storeData = value;
                                    sdata.add(_storeData[2]);
                                  } else if (key ==
                                      widget.detailInfo["Destination"]) {
                                    List<dynamic> _storeData = value;
                                    sdata.add(_storeData[2]);
                                  }
                                });
                              });

                              _fareInfo.add(sdata[1] - sdata[0]);
                              if (temp["BusType"] == "AC") {
                                _fareTotal.add((sdata[1] - sdata[0]) * 14.25);
                              } else {
                                _fareTotal.add((sdata[1] - sdata[0]) * 7.25);
                              }
                              sdata.clear();

                              return Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Card(
                                  color: temp["PasLog"] == 50
                                      ? Colors.red
                                      : Colors.white,
                                  child: ExpansionTile(
                                    key: keyTile,
                                    initiallyExpanded: _isExpanded,
                                    childrenPadding:
                                        EdgeInsets.all(10).copyWith(top: 0),
                                    leading: Icon(Icons.train),
                                    title: Text(
                                      temp["BusNum"],
                                      style:
                                          Theme.of(context).textTheme.headline1,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Available Seats ${50 - temp["PasLog"]}",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text("Bus Type: ${temp["BusType"]}"),
                                      ],
                                    ),
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 150,
                                                child: Text(
                                                  "Station Name",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: 80,
                                                child: Text(
                                                  "ETA",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: 80,
                                                child: Text(
                                                  "Expected \n   Delay",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemBuilder: (cctx, ind) {
                                              Map<String, dynamic> sName =
                                                  mp[(ind + 1).toString()];

                                              var name = sName.keys.toString();
                                              name = name.substring(
                                                  1, name.length - 1);

                                              String t1 =
                                                  sName[name][0].toString();

                                              String hr1 = t1.substring(0, 2);

                                              String min1 = t1.substring(2);

                                              int phr1 = int.parse(hr1);
                                              int pmin1 = int.parse(min1);

                                              String t2 =
                                                  sName[name][1].toString();

                                              String hr2 = t2.substring(0, 2);

                                              String min2 = t2.substring(2);

                                              int phr2 = int.parse(hr2);
                                              int pmin2 = int.parse(min2);

                                              int fh = phr1 + phr2;
                                              int fm = pmin1 + pmin2;

                                              if (fm > 60) {
                                                fh++;
                                                fm = fm - 60;
                                              }

                                              String hh = "";
                                              if (fm > 0 && fm < 10) {
                                                hh = "0" + fm.toString();
                                              } else if (fm == 0) {
                                                hh = "00";
                                              }

                                              return Row(
                                                children: [
                                                  Container(
                                                    width: 150,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Expanded(
                                                        child: Text(
                                                          "$name",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 8),
                                                    child: Container(
                                                      width: 80,
                                                      child: fm < 10
                                                          ? Text(
                                                              "$fh : $hh",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                              ),
                                                            )
                                                          : Text(
                                                              "$fh : $fm",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    width: 80,
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Text(
                                                          "$hr2 : $min2",
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              );
                                            },
                                            itemCount: mp.length,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Time Required",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "00:00",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Travel Distance",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "${_fareInfo[index]} KM",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Total Fare Per Head",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "${_fareTotal[index]} ₹",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 125,
                                                child: TextFormField(
                                                  controller: _controller,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    hintText: "Passengers",
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              FloatingActionButton.extended(
                                                onPressed: () {
                                                  showDialog(
                                                    context: ctx,
                                                    builder: (bui) {
                                                      DateTime now =
                                                          DateTime.now();
                                                      int tID = Random()
                                                              .nextInt(100000) +
                                                          1000000;
                                                      String? cText =
                                                          _controller.text;

                                                      int avaiSeats =
                                                          temp["PasLog"];

                                                      avaiSeats =
                                                          50 - avaiSeats;
                                                      int pasCountTotal = 0;

                                                      if (cText.isNotEmpty) {
                                                        pasCountTotal =
                                                            int.parse(cText);
                                                      }

                                                      if (cText.isEmpty) {
                                                        return AlertDialog(
                                                          title: Text("ERROR"),
                                                          content: Text(
                                                              "At least 1 Ticket Required"),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context,
                                                                        rootNavigator:
                                                                            true)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  "Go Back"),
                                                            ),
                                                          ],
                                                        );
                                                      } else if (avaiSeats <
                                                          pasCountTotal) {
                                                        return AlertDialog(
                                                          title: Text("ERROR"),
                                                          content: Text(
                                                              "Not Enough seats"),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context,
                                                                        rootNavigator:
                                                                            true)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                  "Go Back"),
                                                            ),
                                                          ],
                                                        );
                                                      }

                                                      return AlertDialog(
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text("BUS IT"),
                                                          ],
                                                        ),
                                                        content: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    "Date: ${now.day}-${now.month}-${now.year}"),
                                                                Spacer(),
                                                                Text(
                                                                    "Time:  ${now.hour}:${now.minute}"),
                                                              ],
                                                            ),
                                                            TopInfoGiver(
                                                                "Transaction Id: ",
                                                                tID,
                                                                ctx),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            TopInfoGiver(
                                                                "Customer Name: ",
                                                                "acb xyz",
                                                                ctx),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            TopInfoGiver(
                                                                "Mobile No: ",
                                                                "0123456789",
                                                                ctx),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            TopInfoGiver(
                                                                "Email-ID: ",
                                                                "abc@gmail.com",
                                                                ctx),
                                                            SizedBox(
                                                                height: 20),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                    width: 60),
                                                                Text(
                                                                    "Travel Details"),
                                                              ],
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.black,
                                                              thickness: 2,
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            InfoGiver(
                                                                "Source ",
                                                                widget.detailInfo[
                                                                    "Source"],
                                                                ctx),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            InfoGiver(
                                                                "Destination: ",
                                                                widget.detailInfo[
                                                                    "Destination"],
                                                                ctx),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            TopInfoGiver(
                                                                "BusID: ",
                                                                temp["BusNum"],
                                                                ctx),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            TopInfoGiver(
                                                                "No of Tickets: ",
                                                                _controller
                                                                    .text,
                                                                ctx),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            TopInfoGiver(
                                                                "Price per Head: ",
                                                                _fareTotal[
                                                                    index],
                                                                ctx),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            TopInfoGiver(
                                                                "Total Price: ",
                                                                pasCountTotal *
                                                                    _fareTotal[
                                                                        index],
                                                                ctx),
                                                          ],
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {},
                                                            child:
                                                                FloatingActionButton
                                                                    .extended(
                                                              onPressed:
                                                                  () async {
                                                                await _updateData(
                                                                    temp[
                                                                        "BusNum"],
                                                                    widget.detailInfo[
                                                                        "Destination"]!,
                                                                    pasCountTotal);

                                                                Navigator.of(
                                                                        context,
                                                                        rootNavigator:
                                                                            true)
                                                                    .pop();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              label: Text(
                                                                  "Pay Now"),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                label: Text("Proceed"),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: data.l4.length,
                          );
              },
            ),
          ],
        ),
      ),
    );
  }
}
