// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:minoragain/pages/BasisAnalytics.dart';
import 'package:minoragain/pages/SourceAnalysis.dart';
import 'package:minoragain/pages/newuserPage.dart';
import 'package:minoragain/widget/inputEmail.dart';
import 'package:minoragain/widget/password.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ChartAnalytics.dart';

import 'StartPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.yellow, Colors.redAccent],
          ),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 150,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 5,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/buslogo2.jpg"),
                        fit: BoxFit.fill),
                  ),
                ),
                InputEmail(),
                PasswordInput(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: (Colors.black),
                            blurRadius:
                                5.0, // has the effect of softening the shadow
                            spreadRadius:
                                1.0, // has the effect of extending the shadow
                            offset: Offset(
                              1.0, // horizontal, move right 10
                              1.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => NewUser()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "SignUp",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Spacer(),
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: (Colors.black),
                            blurRadius:
                                5.0, // has the effect of softening the shadow
                            spreadRadius:
                                1.0, // has the effect of extending the shadow
                            offset: Offset(
                              1.0, // horizontal, move right 10
                              1.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => StartPage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 90,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: (Colors.black),
                            blurRadius:
                                5.0, // has the effect of softening the shadow
                            spreadRadius:
                                1.0, // has the effect of extending the shadow
                            offset: Offset(
                              1.0, // horizontal, move right 10
                              1.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (cc) {
                              return AlertDialog(
                                title: Text("Help"),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Women Helpline: 1091/1291"),
                                    Text("Hospital: 102"),
                                    Text("Police Helpline: 100"),
                                    Text("Fire Helpline: 101"),
                                    Text("Covid Helpline: 1800313444222"),
                                    Text("Cyber Crime Helpline: 155620"),
                                    Text("Senior Citizen Helpline: 14567"),
                                    Text(
                                        "Road Accident Emergeny Service: 1073"),
                                    Text("National Emergency: 112"),
                                    Text("RTO: 01123819191"),
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
                        child: Row(
                          children: [
                            Icon(Icons.help),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Help"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 115,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: (Colors.black),
                            blurRadius:
                                5.0, // has the effect of softening the shadow
                            spreadRadius:
                                1.0, // has the effect of extending the shadow
                            offset: Offset(
                              1.0, // horizontal, move right 10
                              1.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        /* onPressed: () async {
                          const url = 'https://flutter.dev';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        }, */
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => BasicAnalytics()));
                        },
                        child: Row(
                          children: [
                            Text(
                              "Statistics",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.analytics,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
