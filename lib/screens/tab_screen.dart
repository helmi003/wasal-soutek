// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'package:chihebapp2/screens/addFeedback_screen.dart';
import 'package:chihebapp2/screens/badFeedBacks_screen.dart';
import 'package:chihebapp2/screens/goodFeedbacks_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TabScreen extends StatefulWidget {
  static const routeName = "/TabScreen";
  final int page;
  TabScreen({required this.page});
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late int currentIndex;
  late List<Widget> children;

  @override
  void initState() {
    currentIndex = widget.page;
    children = [
      GoodFeedbacksScreen(),
      AddFeedbackScreen(),
      BadFeedbacksScreen(),
    ];
    super.initState();
  }

  void _onTabChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: children[currentIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: GNav(
          backgroundColor: primaryColor,
          color: lightColor,
          activeColor: lightColor,
          tabBackgroundColor: lightColor.withOpacity(0.4),
          padding: EdgeInsets.all(10),
          iconSize: 30,
          textSize: 30,
          onTabChange: _onTabChanged,
          gap: 8,
          tabs: [
            GButton(
              icon: FontAwesomeIcons.faceGrinHearts,
              text: "Avis positifs",
            ),
            GButton(
              icon: FontAwesomeIcons.circlePlus,
              text: "Ajouter avis",
            ),
            GButton(
              icon: FontAwesomeIcons.faceSadCry,
              text: "Avis négatifs",
            ),
          ],
        ),
      ),
    );
  }
}
