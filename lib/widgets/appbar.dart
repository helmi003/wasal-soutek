// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:chihebapp2/screens/home_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget appBar(BuildContext context,String text) {
  return AppBar(
      backgroundColor: primaryColor,
      title: Text(
        text,
        style: TextStyle(
            fontSize: 25.sp, fontWeight: FontWeight.w500, color: lightColor),
      ),
      centerTitle: true,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.home,
          size: 28.h,
          color: lightColor,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.person,
            size: 28.h,
            color: lightColor,
          ),
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ProfileScreen(),
            //     ));
          },
        )
      ],
      elevation: 0);
}
