// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:minoragain/pages/BusAnalysis.dart';
import 'package:minoragain/pages/DestinationAnalysis.dart';
import 'package:minoragain/pages/SourceAnalysis.dart';

class BasicAnalytics extends StatefulWidget {
  const BasicAnalytics({Key? key}) : super(key: key);

  @override
  _BasicAnalyticsState createState() => _BasicAnalyticsState();
}

class _BasicAnalyticsState extends State<BasicAnalytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          "Basic Analysis Page",
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
      drawer: Drawer(
        elevation: 15,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
              ),
              child: Text(
                "Analytics",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text("Source Analytics"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SourceAnalysis(),
                  ),
                );
              },
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text("Destination Analytics"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DestinationAnalysis(),
                  ),
                );
              },
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text("Bus Analytics"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BusAnalysis(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/statistics.gif",
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
