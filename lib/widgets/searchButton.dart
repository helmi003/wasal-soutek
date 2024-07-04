// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchButton extends StatelessWidget {
  final VoidCallback onTap;
  const SearchButton(this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding:
              EdgeInsets.only(top: 10.h, bottom: 5.h, left: 15.w, right: 15.w),
          child: SizedBox(
            height: 40.h,
            child: Container(
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                      width: 2.w, color: darkColor.withOpacity(0.7))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rechercher par entreprise ou propriétaire",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: darkColor.withOpacity(0.5), fontSize: 15.sp)),
                  Icon(
                    Icons.search,
                    color: darkColor,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
