// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/Provider.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
                width: 2,
                color: Colors.black,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.black,
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
      Duration(seconds: 5),
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
      backgroundColor: Colors.white,
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
                  "assets/bus5.gif",
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          AnimatedTextKit(
            repeatForever: true,
            isRepeatingAnimation: true,
            animatedTexts: [
              WavyAnimatedText(
                "BUS IT",
                textStyle: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
                speed: Duration(milliseconds: 200),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          AnimatedTextKit(
            //repeatForever: true,
            animatedTexts: [
              TyperAnimatedText(
                "Gateway to your Destination",
                textStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                speed: Duration(
                  milliseconds: 155,
                ),
              ),
            ],
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
    return AlertDialog(
      title: Text("Covid Guidelines"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/mask.jpg"), fit: BoxFit.fill),
                  ),
                ),
                //Spacer(),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/injection.jpg"),
                        fit: BoxFit.fill),
                  ),
                ),
                //Spacer(),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/corona.jpg"),
                        fit: BoxFit.fill),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            /* Text(
              " • All passengers are advised to download the Aarogya Setu app on their mobile phones.\n"
              " • All passengers are required to use face covers/masks, and are required to follow hand hygiene, respiratory hygiene, and environmental hygiene.\n"
              " • All travellers must follow social distancing measures at bus terminals.\n"
              " • Travelers with quarantine seal mark will not be allowed to board the bus",
              textAlign: TextAlign.left,
            ), */
            BulletedList(
              bullet: Icon(
                Icons.check,
                color: Colors.red,
              ),
              listItems: [
                "All passengers are advised to download the Aarogya Setu app on their mobile phones.",
                "All passengers are required to use face covers/masks, and are required to follow hand hygiene, respiratory hygiene, and environmental hygiene.",
                "All travellers must follow social distancing measures at bus terminals.",
                "Travelers with quarantine seal mark will not be allowed to board the bus",
              ],
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => LoginPage(),
              ),
            );
          },
          child: Text("OK"),
        ),
      ],
    );
  }
}
