// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:chihebapp2/screens/feedbackImages_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/backAppbar.dart';
import 'package:chihebapp2/widgets/errorMessage.dart';
import 'package:chihebapp2/widgets/peopleCommentWidget.dart';
import 'package:chihebapp2/widgets/yourMessageWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: backAppBar(context, 'Commentaires'),
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
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        text: 'Pseudo: ',
                        style: TextStyle(color: darkColor),
                        children: [
                          TextSpan(
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                            text: widget.entreprise,
                          )
                        ]))),
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
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FeedbackImagesScreen()));
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20.w,top: 10.h),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.image,color: primaryColor,),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      'Voir les photos',
                      style: TextStyle(fontSize: 16.sp,decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
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
      bottomSheet: Container(
        height: 70.h,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(18.r),
                topLeft: Radius.circular(18.r))),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  cursorColor: primaryColor,
                  controller: messageController,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Message...',
                    hintStyle: TextStyle(
                        color: silverColor,
                        fontSize: 16.sp,
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
                  style: TextStyle(color: primaryColor, fontSize: 16.sp),
                ),
              ),
              IconButton(
                onPressed: () {
                  // addReclamation();
                },
                icon: Icon(
                  Icons.send,
                  size: 40,
                  color: lightColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
