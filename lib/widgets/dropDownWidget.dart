// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownWidget extends StatelessWidget {
  final List items;
  final ValueChanged onChanged;
  final String hint;
  final String? selectedItem;
  final String error;

  const DropDownWidget(
    this.items,
    this.onChanged,
    this.hint,
    this.selectedItem,
    this.error,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: DropdownButtonFormField(
              isExpanded: true,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                border: InputBorder.none,
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
                hintText: hint,
                hintStyle: TextStyle(
                  color: darkColor.withOpacity(0.5),
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              value: selectedItem,
              items: items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16.sp, color: darkColor),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (newValue) {
                onChanged(newValue);
              }),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 40.w, top: 2.h, right: 40.w, bottom: 2.h),
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
