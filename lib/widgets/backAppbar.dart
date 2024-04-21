// ignore_for_file: prefer_const_constructors

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget backAppBar(BuildContext context, String text) {
  return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        text,
        style: TextStyle(
            fontSize: 25.sp, fontWeight: FontWeight.w500, color: lightColor),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 28.h,
          color: lightColor,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      elevation: 0);
}
