// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorMesssage extends StatelessWidget {
  final String message;
  ErrorMesssage(this.message);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: redColor, fontSize: 16.sp, fontWeight: FontWeight.w500),
    );
  }
}
