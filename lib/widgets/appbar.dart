// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget appBar(BuildContext context, String text) {
  return AppBar(
      backgroundColor: primaryColor,
      iconTheme: IconThemeData(color: lightColor),
      title: Text(
        text,
        style: TextStyle(
            fontSize: 25.sp, fontWeight: FontWeight.w500, color: lightColor),
      ),
      centerTitle: true,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      elevation: 0);
}
