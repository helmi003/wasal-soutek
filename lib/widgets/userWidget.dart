// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserWidget extends StatelessWidget {
  final String username;
  final String fullname;
  UserWidget(this.username, this.fullname);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        username,
        style: TextStyle(
            fontSize: 16.sp, color: lightColor, fontWeight: FontWeight.w600),
      ),
      subtitle: fullname == " "
          ? null
          : Text(
              fullname,
              style: TextStyle(
                fontSize: 16.sp,
                color: lightColor,
              ),
            ),
    );
  }
}
