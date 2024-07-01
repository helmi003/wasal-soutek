// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

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
      width: 150.w,
      height: 40.h,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: !isLoading ? onTap : () {},
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: lightColor,
                )
              : Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: lightColor,
                  ),
                ),
        ),
      ),
    );
  }
}
