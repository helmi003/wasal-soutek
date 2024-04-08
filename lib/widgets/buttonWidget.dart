// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final bool isLoading;

  ButtonWidget(this.onTap, this.label, this.isLoading);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.w,
      height: 50.h,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: onTap,
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: lightColor,
                )
              : Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp, // Use screenutil for responsive font sizes
                    fontWeight: FontWeight.bold,
                    color: lightColor,
                  ),
                ),
        ),
      ),
    );
  }
}
