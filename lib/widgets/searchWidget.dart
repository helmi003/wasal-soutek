// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController search;
  final String hint;
  final Function(String) onSubmitted;
  const SearchWidget(this.search, this.hint, this.onSubmitted);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 5.h, left: 15.w, right: 15.w),
      child: SizedBox(
        height: 40.h,
        child: TextField(
            cursorColor: darkColor,
            controller: search,
            decoration: InputDecoration(
                fillColor: Colors.transparent,
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(top: 11.h, bottom: 11.h, left: 11.w),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(
                        color: darkColor.withOpacity(0.7), width: 2.w)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(
                        color: darkColor.withOpacity(0.7), width: 2.w)),
                hintText: hint,
                hintStyle: TextStyle(
                    color: darkColor.withOpacity(0.5), fontSize: 15.sp),
                suffixIcon: Icon(
                  Icons.search,
                  color: darkColor,
                )),
            onChanged: onSubmitted,
            style: TextStyle(color: darkColor, fontSize: 14.sp)),
      ),
    );
  }
}
