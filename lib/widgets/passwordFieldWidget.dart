// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String error;
  final String label;
  final bool obscureText;
  final VoidCallback showHide;
  PasswordFieldWidget(
      this.controller, this.label, this.error, this.obscureText, this.showHide);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextFormField(
              cursorColor: darkColor,
              obscureText: obscureText,
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                    onTap: showHide,
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: darkColor,
                    )),
                fillColor: Colors.transparent,
                filled: true,
                border: InputBorder.none,
                labelText: label,
                labelStyle: TextStyle(
                    color: darkColor.withOpacity(0.5), fontSize: 16.sp),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                      color: error != "" ? redColor : primaryColor, width: 2.w),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                      color: error != "" ? redColor : primaryColor, width: 2.w),
                ),
              ),
              style: TextStyle(color: darkColor, fontSize: 16.sp)),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 40.w, top: 2.h, right: 40.w, bottom: 4.h),
              child: Text(
                error != "" ? error : "",
                style: TextStyle(
                  color: redColor,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
