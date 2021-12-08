// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minoragain/models/Provider.dart';
import 'package:minoragain/pages/HomePage.dart';
import 'package:provider/provider.dart';

import 'BusDetailScreen.dart';

class HomePageScreen extends StatelessWidget {
  //const HomePageScreen({ Key? key }) : super(key: key);

  Map<String, String> details = {"Source": "", "Destination": ""};

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.deepOrangeAccent,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.train,
              size: 28,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Plan My Journey",
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.train,
              size: 28,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(55),
            bottomRight: Radius.circular(55),
          ),
        ),
        elevation: 20,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "${now.day}/${now.month}/${now.year}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    DateFormat.jm().format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              HomePage("Source Station", details),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: HomePage("Destination Station", details),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (bui) {
                          return AlertDialog(
                            title: Text(
                              "Price Brochure",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("NON AC PRICE: 10₹ per KM"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("AC PRICE: 15₹ per KM"),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "Price Brochure",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrangeAccent,
                    ),
                    onPressed: () {
                      Provider.of<BList>(context, listen: false).screenChange();

                      String? s1 = "";
                      s1 = details["Source"];
                      String? s2 = "";
                      s2 = details["Destination"];
                      if (s1 == "" ||
                          s2 == "" ||
                          s1 == null ||
                          s2 == null ||
                          (s1 == s2)) {
                        showDialog(
                          context: (context),
                          builder: (cptx) {
                            return AlertDialog(
                              title: Text("ERROR !"),
                              content: Text("Please eneter valid options"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Provider.of<BList>(context, listen: false)
                                        .screenChange();
                                    Navigator.of(cptx).pop();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        //FocusScope.of(context).unfocus();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BusDetailScreen(details),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "SEARCH BUSES",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Image.asset("assets/bus3.gif"),
            ],
          ),
        ),
      ),
    );
  }
}
