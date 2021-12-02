// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:minoragain/widget/button.dart';
import 'package:minoragain/widget/first.dart';
import 'package:minoragain/widget/forgot.dart';
import 'package:minoragain/widget/inputEmail.dart';
import 'package:minoragain/widget/password.dart';
import 'package:minoragain/widget/textLogin.dart';
import 'package:minoragain/widget/verticalText.dart';

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
            colors: [Colors.white, Colors.white],
          ),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                /*Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),*/
                SizedBox(
                  height: 30,
                ),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/buslogo1.jpg"),
                            fit: BoxFit.fill),
                      ),
                    ),
                    //Spacer(),
                    
                  ],
                ), */
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
                FirstTime(),
                ButtonLogin(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
