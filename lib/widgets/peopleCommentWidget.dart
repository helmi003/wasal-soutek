// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PeopleCommnetWidget extends StatelessWidget {
  final String userName;
  final String userImage;
  final String message;
  final String time;
  final bool show;
  final VoidCallback deleteMessage;
  final VoidCallback showDate;
  PeopleCommnetWidget(this.userName, this.userImage, this.message, this.time,
      this.show,this.deleteMessage, this.showDate);

  @override
  Widget build(BuildContext context) {
    final url = dotenv.env['API_URL'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(left: 35.w), child: Text(userName)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: Image.network(
                  "$url/${userImage.replaceAll('\'', '/')}",
                  height: 20,
                ),
              ),
            ),
            GestureDetector(
              onLongPress: deleteMessage,
              onTap: showDate,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 330.w
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: show
                      ? secondaryColor.withOpacity(0.5)
                      : secondaryColor.withOpacity(0.8),
                  border: Border.all(
                      width: 2,
                      color:
                          show ? primaryColor.withOpacity(0.7) : primaryColor),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.r),
                    bottomRight: Radius.circular(18.r),
                    topLeft: Radius.circular(18.r),
                    topRight: Radius.circular(18.r),
                  ),
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: lightColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 25.w),
          child: Text(
            show ? time : "",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: darkColor,
            ),
          ),
        )
      ],
    );
  }
}
