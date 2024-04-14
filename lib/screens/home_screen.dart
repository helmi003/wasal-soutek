// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:chihebapp2/screens/tab_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/homeAppbar.dart';
import 'package:chihebapp2/widgets/iconButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      appBar: homeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              color: secondaryColor.withOpacity(0.7),
              child: Container(
                padding: EdgeInsets.all(10),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text:
                        "Dans cette application, vous pouvez ajouter des réclamations en cliquant sur le bouton ",
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.format_list_bulleted_add,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                      TextSpan(
                        text:
                            ", et également consulter la liste des réclamations en cliquant sur ",
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.list,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                      // if (user.role == "admin") ...[
                        TextSpan(
                          text:
                              ", et aussi ajouter/consulter des utilisateurs en cliquant sur le bouton ",
                        ),
                        WidgetSpan(
                          child: Icon(
                            Icons.groups,
                            color: primaryColor,
                            size: 30,
                          ),
                        ),
                      // ],
                    ],
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: lightColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            IconButtonWidget('List des réclamation', Icons.list,false ,() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TabScreen()));
            }),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
