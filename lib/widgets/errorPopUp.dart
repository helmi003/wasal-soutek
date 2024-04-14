// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorPopUp extends StatelessWidget {
  final String title;
  final String errorMsg;
  final Color color;
  ErrorPopUp(this.title, this.errorMsg, this.color);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: secondaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r))),
      title: Text(title,
          style: TextStyle(
            fontSize: 25.sp,
            color: color,
            fontWeight: FontWeight.bold,
          )),
      content: Text(errorMsg,
          style: TextStyle(
              fontSize: 18.sp, fontWeight: FontWeight.w500, color: lightColor)),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            ),
            child: Text("D'accord",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: lightColor)))
      ],
    );
  }
}
