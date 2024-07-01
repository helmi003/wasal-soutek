// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddComment extends StatelessWidget {
  final TextEditingController message;
  final VoidCallback addMessage;
  const AddComment(this.message, this.addMessage);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(18.r), topLeft: Radius.circular(18.r))),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                cursorColor: lightColor,
                controller: message,
                decoration: InputDecoration(
                  fillColor: lightColor.withOpacity(0.2),
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'Message...',
                  hintStyle: TextStyle(
                      color: lightColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(color: lightColor, width: 3.w),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide(color: lightColor, width: 3.w),
                  ),
                ),
                style: TextStyle(color: lightColor, fontSize: 16.sp),
              ),
            ),
            IconButton(
              onPressed: addMessage,
              icon: Icon(
                Icons.send,
                size: 40,
                color: lightColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
