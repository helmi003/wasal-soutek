// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String error;
  CustomTextArea(this.controller, this.label, this.error);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextFormField(
              maxLength: 500,
              minLines: 6,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              cursorColor: darkColor,
              controller: controller,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                border: InputBorder.none,
                labelText: label,
                labelStyle: TextStyle(color: darkColor.withOpacity(0.5), fontSize: 16.sp),
                alignLabelWithHint: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                      color: error != "" ? redColor : primaryColor, width: 2.w),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(color: error != "" ? redColor : primaryColor, width: 2.w),
                ),
              ),
              style: TextStyle(color: darkColor, fontSize: 16.sp)),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 40.w, right: 40.w, bottom: 4.h),
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
