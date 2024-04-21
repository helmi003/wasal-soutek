// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcceptOrDecline extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onTap;
  AcceptOrDecline(this.title, this.message, this.onTap);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.r))),
      title: Text(title,
          style: TextStyle(
            fontSize: 22.sp,
            color: redColor,
            fontWeight: FontWeight.bold,
          )),
      content: Text(message,
          style: TextStyle(
              fontSize: 16.sp, fontWeight: FontWeight.w500, color: lightColor)),
      actions: <Widget>[
        TextButton(
            onPressed: onTap,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
            ),
            child: Text("Oui",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: lightColor))),
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
              backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
            ),
            child: Text("Non",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: lightColor)))
      ],
    );
  }
}
