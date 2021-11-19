// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'BusDetailScreen.dart';
import 'package:minoragain/pages/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:minoragain/models/Provider.dart';

class HomePageScreen extends StatelessWidget {
  //const HomePageScreen({ Key? key }) : super(key: key);

  Map<String, String> details = {"Source": "", "Destination": ""};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text("Home"),
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
              HomePage("Source Station", details),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: HomePage("Destination Station", details),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<BList>(context, listen: false).screenChange();
                  print("Source is ${details["Source"]}");
                  print("Destination is ${details["Destination"]}");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BusDetailScreen(details),
                    ),
                  );
                },
                child: Text("OK"),
              ),
              SizedBox(
                height: 25,
              ),
              Image.asset("assets/b1.png"),
            ],
          ),
        ),
      ),
    );
  }
}
