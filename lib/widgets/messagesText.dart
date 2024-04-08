// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageText extends StatelessWidget {
  final String text;
  MessageText(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.all(10.w),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18.sp, color: darkColor, fontWeight: FontWeight.w600),
      ),
    ));
  }
}
