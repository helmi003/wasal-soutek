// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:chihebapp2/screens/fullScreenImage_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/errorPopUp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PendingPostWidget extends StatelessWidget {
  final String userImage;
  final String name;
  final String time;
  final VoidCallback approve;
  final VoidCallback refuse;
  final String entreprise;
  final String message;
  final String lien;
  final List images;
  const PendingPostWidget(this.userImage, this.name, this.time, this.approve,
      this.refuse, this.entreprise, this.message, this.lien, this.images);

  @override
  Widget build(BuildContext context) {
    final url = dotenv.env['API_URL'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                  radius: 20.r,
                  backgroundImage:
                      NetworkImage("$url/${userImage.replaceAll('\'', '/')}")),
              title: Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: lightColor),
              ),
              subtitle: Text(
                time,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: darkColor.withOpacity(0.8)),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: "Nom d'entreprise: ",
                        style: TextStyle(
                            color: darkColor, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            style: TextStyle(
                                color: lightColor, fontWeight: FontWeight.w400),
                            text: entreprise,
                          )
                        ]))),
            if (lien != "")
              Padding(
                  padding:
                      EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: "Lien d'entreprise: ",
                          style: TextStyle(
                            color: darkColor,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              style: TextStyle(
                                  color: lightColor,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline),
                              text: lien,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  try {
                                    await launchUrl(Uri.parse(lien));
                                  } catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => ErrorPopUp(
                                        'Alert',
                                        'Ce lien est inaccessible pour le moment',
                                        redColor,
                                      ),
                                    );
                                  }
                                },
                            )
                          ]))),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  message,
                  style: TextStyle(color: lightColor),
                )),
            Center(
              child: Stack(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FullScreenImage(images)));
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 20.w),
                      constraints: BoxConstraints(maxHeight: 200.h),
                      child: Image.network(
                        "$url/uploads/${images[0]}",
                        fit: BoxFit.cover,
                      )),
                ),
                if (images.length > 1)
                  Positioned(
                    bottom: 15.h,
                    right: 25.w,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: silverColor.withOpacity(0.8),
                      ),
                      child: Text(
                        '+${images.length - 1} ',
                        style: TextStyle(
                          color: lightColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: refuse,
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.xmark,
                        color: redColor,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Refuser',
                        style: TextStyle(
                            color: lightColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: approve,
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.check,
                        color: greenColor,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Approuver',
                        style: TextStyle(
                            color: lightColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
