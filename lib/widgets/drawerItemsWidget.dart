// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerItemWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  DrawerItemWidget(this.text, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
      leading: Icon(
        icon,
        size: 25.r,
        color: secondaryColor,
      ),
      onTap: onTap,
    );
  }
}
