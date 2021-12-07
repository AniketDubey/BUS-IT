// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minoragain/pages/AllStation.dart';
import 'package:minoragain/pages/HomePageScreen.dart';
import 'package:minoragain/pages/Scanqr.dart';
import 'ProfilePage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class StartPage extends StatefulWidget {
  //const StartPage({ Key? key }) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomePageScreen(),
      Scanqr(),
      AllStation(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        icon: Icon(Icons.book),
        title: ("Book Us"),
        activeColorPrimary: Colors.blueGrey,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        icon: Icon(Icons.qr_code),
        title: ("QR Code"),
        activeColorPrimary: Colors.blueGrey,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        icon: Icon(Icons.home),
        title: ("Station \n Info"),
        activeColorPrimary: Colors.blueGrey,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Colors.blueGrey,
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.yellow, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          false, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
