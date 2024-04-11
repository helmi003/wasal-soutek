// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'package:chihebapp2/screens/about_screen.dart';
import 'package:chihebapp2/screens/home_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/drawerItemsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Helmi',
                style: TextStyle(
                    color: lightColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp)),
            accountEmail: Text('helmi.br1999@gmail.com',
                style: TextStyle(
                    color: lightColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp)),
            currentAccountPicture: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('profile');
                },
                child: CircleAvatar(
                    radius: 80.r,
                    backgroundImage: AssetImage('assets/images/user.png'))),
            decoration: BoxDecoration(
              color: primaryColor,
            ),
          ),
          DrawerItemWidget("Page d'acceuil", FontAwesomeIcons.house, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }),
          DrawerItemWidget("À propos", FontAwesomeIcons.circleInfo, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AboutScreen()));
          }),
          Divider(
            color: darkColor.withOpacity(0.5),
            indent: 20.w,
            endIndent: 20.w,
          ),
          ListTile(
            title: Text("Se déconnecter",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
            leading: Transform.rotate(
                angle: 180 * 3.14 / 180,
                child: Icon(
                  FontAwesomeIcons.rightFromBracket,
                  size: 25.r,
                  color: secondaryColor,
                )),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}
