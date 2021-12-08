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

class _BasicAnalyticsState extends State<BasicAnalytics>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: ' Source\nAnalysis',
    ),
    Tab(text: 'Destination \n   Analysis'),
    Tab(text: '   Bus \nAnalysis'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        bottom: TabBar(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          controller: _tabController,
          tabs: myTabs,
        ),
        title: Text(
          "Analytics",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SourceAnalysis(),
          DestinationAnalysis(),
          BusAnalysis(),
        ],
      ),
    );
  }
}
