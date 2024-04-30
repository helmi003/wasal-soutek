// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/appbar.dart';
import 'package:chihebapp2/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(context, "Acceuil"),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text:
                      "Dans cette application, exprimez-vous en partageant vos retours d'expérience sur différents services, produits, et entreprises. Que ce soit une expérience positive à partager ",
                  children: [
                    WidgetSpan(
                      child: Icon(
                        FontAwesomeIcons.faceGrinHearts,
                        color: primaryColor,
                        size: 30,
                      ),
                    ),
                    TextSpan(
                      text: " ou une déception à exprimer ",
                    ),
                    WidgetSpan(
                      child: Icon(
                        FontAwesomeIcons.faceSadCry,
                        color: primaryColor,
                        size: 30,
                      ),
                    ),
                    TextSpan(
                      text:
                          ", votre voix compte pour aider les autres utilisateurs à faire des choix éclairés.",
                    ),
                  ],
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: darkColor,
                  ),
                ),
              ),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: "Explorez les feedbacks des autres utilisateurs ",
                  children: [
                    WidgetSpan(
                      child: Icon(
                        FontAwesomeIcons.peopleGroup,
                        color: primaryColor,
                        size: 30,
                      ),
                    ),
                  ],
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: darkColor,
                  ),
                ),
              ),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text:
                      "Engagez-vous avec la communauté en laissant des commentaires  ",
                  children: [
                    WidgetSpan(
                      child: Icon(
                        FontAwesomeIcons.comments,
                        color: primaryColor,
                        size: 30,
                      ),
                    ),
                  ],
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: darkColor,
                  ),
                ),
              ),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: "Enrichissez vos feedbacks en ajoutant des photos  ",
                  children: [
                    WidgetSpan(
                      child: Icon(
                        FontAwesomeIcons.image,
                        color: primaryColor,
                        size: 30,
                      ),
                    ),
                    TextSpan(
                      text: " pour illustrer votre expérience.",
                    ),
                  ],
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: darkColor,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: SvgPicture.asset(
                  'assets/images/undraw_feedback.svg',
                  height: 250.h,
                  semanticsLabel: 'undraw_feedback',
                ),
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
