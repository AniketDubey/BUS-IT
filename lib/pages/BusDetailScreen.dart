// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minoragain/models/Provider.dart';
import 'package:minoragain/pages/Scanqr.dart';
import 'package:provider/provider.dart';
//import 'package:minoragain/screens/ListofDetails.dart';

class BusDetailScreen extends StatefulWidget {
  //const BusDetailScreen({Key? key}) : super(key: key);

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

    //print(PasCount);
    //print("Bus id hai => $Bid");
    //print("Station id hai => $sID");
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

  //int totalCount = 0;

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () async {
        Provider.of<BList>(context, listen: false).screenChange();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/b2.jfif",
                fit: BoxFit.fill,
              ),
            ),
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
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              )
                            ],
                          )
                        : ListView.builder(
                            itemBuilder: (ctx, index) {
                              Map<String, dynamic> temp = data.l4[index];
                              Map<String, dynamic> mp = temp["Sdetails"];

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
                                    //trailing: Text("Time Required"),
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
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: 80,
                                                child: Text(
                                                  "Delay",
                                                  style: TextStyle(
                                                    fontSize: 18,
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
                                              //print(hr1);
                                              String min1 = t1.substring(2);
                                              //print(min1);

                                              int phr1 = int.parse(hr1);
                                              int pmin1 = int.parse(min1);

                                              String t2 =
                                                  sName[name][1].toString();

                                              String hr2 = t2.substring(0, 2);
                                              //print(hr2);
                                              String min2 = t2.substring(2);
                                              //print(min2);

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

                                              /* print(t1);
                                              print(t2);

                                              if (fm < 10) {
                                                print("final is $fh : $hh");
                                              } else {
                                                print("final is $fh : $fm");
                                              } */

                                              //print(t1);
                                              //print(h1);

                                              return Row(
                                                children: [
                                                  Container(
                                                    width: 150,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Text(
                                                        "$name",
                                                        style: TextStyle(
                                                          fontSize: 18,
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
                                                      child: /* Text(
                                                        "${sName[name][0]}",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ), */
                                                          fm < 10
                                                              ? Text(
                                                                  "$fh : $hh",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "$fh : $fm",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
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
                                                        child: /* Text(
                                                        "${sName[name][1]}",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ) */
                                                            Text(
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
                                              Text("Time Required"),
                                              Spacer(),
                                              Text("Here is time"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 85,
                                                child: TextFormField(
                                                  controller: _controller,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    hintText: "Ticket",
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              FloatingActionButton.extended(
                                                onPressed: () async {
                                                  print(_controller.text);
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  String? count =
                                                      _controller.text;

                                                  if (count.isEmpty) {
                                                    _showScaffold(context,
                                                        "At least 1 ticket requried");
                                                  } else {
                                                    int val1 = temp["PasLog"];

                                                    val1 = 50 - val1;

                                                    int val2 = int.parse(
                                                        _controller.text);

                                                    if (val2 > val1) {
                                                      _showScaffold(context,
                                                          "Not enough seats avialable");
                                                    } else {
                                                      _showScaffold(context,
                                                          "Payment Done");
                                                      await _updateData(
                                                          temp["BusNum"],
                                                          widget.detailInfo[
                                                              "Destination"]!,
                                                          val2);
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  }
                                                },
                                                label: Text("Pay Now"),
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
