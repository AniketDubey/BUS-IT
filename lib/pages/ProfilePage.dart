// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          "Hello Mr. User",
          style: TextStyle(color: Colors.black),
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
                "BUS ME UP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.wallet_travel),
              title: Text("Past Bookings"),
            ),
            Divider(
              thickness: 2,
            ),
            ListTile(
              leading: Icon(Icons.wallet_membership),
              title: Text("Prime Members"),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/profile.gif",
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
