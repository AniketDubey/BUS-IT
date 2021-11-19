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
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                InputEmail(),
                PasswordInput(),
                ButtonLogin(),
                FirstTime(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
