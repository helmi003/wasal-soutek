// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:chihebapp2/screens/comments_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/errorPopUp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class PostWidget extends StatelessWidget {
  final String id;
  final bool review;
  final String userImage;
  final String name;
  final String time;
  final bool allowedToDelete;
  final VoidCallback delete;
  final String entreprise;
  final String message;
  final String lien;
  final List images;
  const PostWidget(
      this.id,
      this.review,
      this.userImage,
      this.name,
      this.time,
      this.allowedToDelete,
      this.delete,
      this.entreprise,
      this.message,
      this.lien,
      this.images);

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
              leading: InstaImageViewer(
                child: CircleAvatar(
                    radius: 20.r,
                    backgroundImage: NetworkImage(
                        "$url/${userImage.replaceAll('\'', '/')}")),
              ),
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
              trailing: allowedToDelete
                  ? IconButton(
                      icon: Icon(
                        Icons.close,
                        color: lightColor,
                        size: 25.h,
                      ),
                      onPressed: delete,
                    )
                  : null,
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
                InstaImageViewer(
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
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.comments,
                    color: lightColor,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(
                    'Commentaires',
                    style: TextStyle(
                        color: lightColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommentsScreen(
                            id,
                            review,
                            userImage,
                            name,
                            time,
                            allowedToDelete,
                            entreprise,
                            message,
                            lien,
                            images)));
              },
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
