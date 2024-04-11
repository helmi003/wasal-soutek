// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:chihebapp2/widgets/addComment.dart';
import 'package:chihebapp2/widgets/choosePictureType.dart';
import 'package:chihebapp2/widgets/feedbackImages.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/backAppbar.dart';
import 'package:chihebapp2/widgets/errorMessage.dart';
import 'package:chihebapp2/widgets/peopleCommentWidget.dart';
import 'package:chihebapp2/widgets/yourMessageWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentsScreen extends StatefulWidget {
  final String userImage;
  final String name;
  final String time;
  final VoidCallback delete;
  final String entreprise;
  final String message;
  final String lien;
  CommentsScreen(this.userImage, this.name, this.time, this.delete,
      this.entreprise, this.message, this.lien);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController messageController = TextEditingController();
  bool show = false;
  bool user = true;
  File? _photo;
  String photo = "";
  ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: backAppBar(context, widget.entreprise),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                  radius: 20.r, backgroundImage: AssetImage(widget.userImage)),
              title: Text(
                widget.name,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: darkColor),
              ),
              subtitle: Text(
                widget.time,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: darkColor),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.close,
                  color: darkColor,
                  size: 25.h,
                ),
                onPressed: widget.delete,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Text(
                  widget.message,
                  style: TextStyle(color: darkColor),
                )),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: "Lien d'association: ",
                        style: TextStyle(color: darkColor),
                        children: [
                          TextSpan(
                            style: TextStyle(
                                color: primaryColor,
                                decoration: TextDecoration.underline),
                            text: widget.lien,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (!await launchUrl(Uri.parse(widget.lien))) {
                                  throw showDialog(
                                      context: context,
                                      builder: (context) => ErrorMessage(
                                          'Alert',
                                          'Ce site est inaccessible pour le moment',
                                          redColor));
                                }
                              },
                          )
                        ]))),
            SizedBox(height: 10.h),
            FeedbackImages(),
            SizedBox(
              height: 10.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  'Comentaires:',
                  style: TextStyle(
                      fontSize: 25.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.w700),
                )),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) => user
                  ? PeopleCommnetWidget(
                      'Khaled Bouajila',
                      "assets/images/user.png",
                      "SomethingSomethingSomethingSomething SomethingSomethingSomething SomethingSomething",
                      "14:50 - 02/06/2024",
                      show, () {
                      setState(() {
                        show = !show;
                      });
                    })
                  : YourMessageWidget(
                      "SomethingSomethingSomethingSomething SomethingSomethingSomething SomethingSomething",
                      "14:50 - 02/06/2024",
                      show,
                      () {}, () {
                      setState(() {
                        show = !show;
                      });
                    }),
            ),
            SizedBox(
              height: 70.h,
            )
          ],
        ),
      ),
      bottomSheet: AddComment(messageController, () {}
      ),
    );
  }
}
