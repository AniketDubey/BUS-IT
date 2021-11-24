// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/Provider.dart';

import 'package:flutter/material.dart';
import 'package:minoragain/pages/login.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.9),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Theme.of(context).primaryColor.withOpacity(1),
              ),
            ),
          ),
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 20,
          ),
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            headline2: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        home: FirstScreen(),
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  //const FirstScreen({ Key? key }) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset(
                  "assets/b1.png",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  //const SecondScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
