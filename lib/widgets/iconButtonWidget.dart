// ignore_for_file: sort_child_properties_last, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconButtonWidget extends StatelessWidget {
  VoidCallback onTap;
  String text;
  IconData icon;
  final bool isLoading;

  IconButtonWidget(this.text, this.icon, this.isLoading, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300.w,
        height: 50.h,
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: lightColor,
                )
              : Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        icon,
                        size: 25.h,
                        color: primaryColor,
                      ),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: darkColor),
                      ),
                    ],
                  ),
              ),
        ),
        decoration: BoxDecoration(
            color: silverColor.withOpacity(0.4), borderRadius: BorderRadius.circular(16.r)),
      ),
    );
  }
}
