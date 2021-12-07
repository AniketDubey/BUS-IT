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
        title: Text("Hello Mr. User"),
      ),
      drawer: Drawer(
        elevation: 15,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
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
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.wallet_travel),
              title: Text("Past Bookings"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.wallet_membership),
              title: Text("Prime Members"),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("Your Profile"),
      ),
    );
  }
}
