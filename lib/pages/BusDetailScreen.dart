// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minoragain/models/Provider.dart';
import 'package:provider/provider.dart';
//import 'package:minoragain/screens/ListofDetails.dart';

class BusDetailScreen extends StatefulWidget {
  //const BusDetailScreen({Key? key}) : super(key: key);

  Map<String, String> _details;
  BusDetailScreen(this._details);

  @override
  _BusDetailScreenState createState() => _BusDetailScreenState();
}

class _BusDetailScreenState extends State<BusDetailScreen> {
  bool _isLoading = true;

  void submitData() async {
    await Provider.of<BList>(context, listen: false).fetchData(widget._details);
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    submitData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<BList>(context, listen: false).screenChange();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: Consumer<BList>(
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
                              child: ListTile(
                                leading: Icon(Icons.train),
                                title: Text(temp["BusNum"]),
                                subtitle: Text(
                                    "Available Seats ${100 - temp["PasLog"]}"),
                                trailing: Text("Time Required"),
                                onTap: () {
                                  showDialog(
                                    context: ctx,
                                    builder: (cc) {
                                      return AlertDialog(
                                        //scrollable: true,
                                        title: Text("Station Information"),
                                        content: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Station Name"),
                                                  Spacer(),
                                                  Text("ETA"),
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

                                                  var name =
                                                      sName.keys.toString();
                                                  name = name.substring(
                                                      1, name.length - 1);

                                                  return Row(
                                                    children: [
                                                      Text("$name"),
                                                      Spacer(),
                                                      Text("${sName[name][0]}"),
                                                    ],
                                                  );
                                                },
                                                itemCount: mp.length,
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
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
                        itemCount: data.l4.length,
                      );
          },
        ),
      ),
    );
  }
}
