// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/acceptOrDeclineWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget homeAppBar(BuildContext context) {
  return AppBar(
      backgroundColor: primaryColor,
      title: Text(
        'Accueil',
        style: TextStyle(
            fontSize: 25.sp, fontWeight: FontWeight.w500, color: lightColor),
      ),
      centerTitle: true,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      leading: IconButton(
        icon: Transform.rotate(
            angle: 180 * 3.14 / 180,
            child: Icon(
              Icons.logout,
              size: 28.h,
              color: lightColor,
            )),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AcceptOrDecline(
                "Alert", "Êtes-vous sûr de vouloir vous déconnecter?",
                () async {
              // await auth.signOut();
              // final SharedPreferences prefs =
              //     await SharedPreferences.getInstance();
              // prefs.remove('user');
              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   LoginScreen.routeName,
              //   (Route<dynamic> route) => false,
              // );
            }),
          );
        },
      ),
      elevation: 0);
}
