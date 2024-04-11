// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/acceptOrDeclineWidget.dart';
import 'package:chihebapp2/widgets/appbar.dart';
import 'package:chihebapp2/widgets/drawerWidget.dart';
import 'package:chihebapp2/widgets/postWidgte.dart';
import 'package:chihebapp2/widgets/searchWidget.dart';
import 'package:flutter/material.dart';

class BadFeedbacksScreen extends StatefulWidget {
  const BadFeedbacksScreen({super.key});

  @override
  State<BadFeedbacksScreen> createState() => _BadFeedbacksScreenState();
}

class _BadFeedbacksScreenState extends State<BadFeedbacksScreen> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(context, 'Avis négatifs'),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(search, 'Rechercher un avis', (value) {
              setState(() {
                search.text = value;
              });
            }),
            PostWidget('assets/images/user.png', 'Helmi Ben Romdhane',
                '14:50 - 12/01/2024', () {
              showDialog(
                  context: context,
                  builder: (context) => AcceptOrDecline("Êtes vous sûr?",
                      "Voulez-vous vraiment supprimer ce post?", () {}));
            },
                "Vermeg",
                'datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata',
                'https://www.facebook.com', [
              'assets/images/helmi.jpg',
              'assets/images/helmi.jpg',
              'assets/images/helmi.jpg',
              'assets/images/helmi.jpg',
            ]),
            PostWidget('assets/images/user.png', 'Helmi Ben Romdhane',
                '14:50 - 12/01/2024', () {
              showDialog(
                  context: context,
                  builder: (context) => AcceptOrDecline("Êtes vous sûr?",
                      "Voulez-vous vraiment supprimer ce post?", () {}));
            },
                "Vermeg",
                'datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata',
                'https://www.facebook.com', [
              'assets/images/helmi.jpg',
              'assets/images/helmi.jpg',
              'assets/images/helmi.jpg',
              'assets/images/helmi.jpg',
            ]),
            PostWidget('assets/images/user.png', 'Helmi Ben Romdhane',
                '14:50 - 12/01/2024', () {
              showDialog(
                  context: context,
                  builder: (context) => AcceptOrDecline("Êtes vous sûr?",
                      "Voulez-vous vraiment supprimer ce post?", () {}));
            },
                "Vermeg",
                'datadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadatadata',
                'https://www.facebook.com', [
              'assets/images/helmi.jpg',
              'assets/images/helmi.jpg',
              'assets/images/helmi.jpg',
              'assets/images/helmi.jpg',
            ]),
          ],
        ),
      ),
    );
  }
}
