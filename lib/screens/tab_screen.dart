// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'package:chihebapp2/screens/home_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TabScreen extends StatefulWidget {
  static const routeName = "/TabScreen";
  final String role;
  TabScreen({required this.role});
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int currentIndex = 0;
  late List<Widget> children;
  

  @override
  void initState() {
    children = [
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      // if (widget.role == "admin") ListOfUsersScreen(),
      // AddReclamedUser(),
    ];
    super.initState();
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
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            gap: 8,
            tabs: [
              GButton(
                icon: Icons.list,
                text: "Réclamations",
              ),
              if (widget.role == "admin")
                GButton(
                  icon: Icons.groups,
                  text: "Utilisateurs",
                ),
              GButton(
                icon: Icons.format_list_bulleted_add,
                text: "Ajouter Réclamation",
              ),
            ]),
      ),
    );
  }
}
