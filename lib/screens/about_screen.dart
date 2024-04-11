import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/backAppbar.dart';
import 'package:chihebapp2/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: backAppBar(context, 'À propos'),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(children: []),
      ),
    );
  }
}