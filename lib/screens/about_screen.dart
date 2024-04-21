// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/appbar.dart';
import 'package:chihebapp2/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(context, 'À propos'),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Center(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Bienvenue sur l'application ",
                      style: TextStyle(
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w500,
                          color: darkColor),
                      children: [
                        TextSpan(
                            text: "Wasal Soutek",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor)),
                      ])),
            ),
            Image.asset(
              'assets/images/logo_name.png',
              height: 150.h,
            ),
            SizedBox(height: 10.h),
            Text(
                "Nous savons tous que parfois, les choses ne se passent pas comme prévu. Que ce soit une expérience client décevante ou au contraire, une expérience exceptionnelle, nous voulons offrir à chacun une plateforme où il peut s'exprimer librement.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: darkColor)),
            SizedBox(height: 10.h),
            Image.asset(
              'assets/images/satisfaction_list.png',
              height: 100.h,
            ),
            SizedBox(height: 10.h),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    text:
                        "Imaginez-vous avoir rencontré un problème avec un service, un produit ou une entreprise. Vous souhaitez partager votre expérience pour aider les autres utilisateurs à prendre des décisions éclairées. Ou peut-être avez-vous été tellement impressionné par un service que vous voulez le recommander à tout le monde. C'est là que ",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: darkColor),
                    children: [
                      TextSpan(
                          text: "Wasal Soutek",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor)),
                      TextSpan(text: " intervient !"),
                    ])),
            SizedBox(height: 10.h),
            Image.asset(
              'assets/images/satisfaction.png',
              height: 100.h,
            ),
            SizedBox(height: 10.h),
            Text(
                "Notre application vous permet de partager vos retours d'expérience, qu'ils soient positifs ou négatifs, sur différentes entreprises, services, marques, agences, et bien plus encore. Vous pouvez expliquer ce qui s'est bien passé ou ce qui aurait pu être amélioré. Votre voix compte, et nous voulons vous offrir un espace où vous pouvez la faire entendre.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: darkColor)),
            SizedBox(height: 10.h),
            Image.asset(
              'assets/images/feedback.png',
              height: 100.h,
            ),
            SizedBox(height: 10.h),
            Text(
                "Mais ce n'est pas tout. Nous savons également que la confiance est essentielle dans ce processus. C'est pourquoi nous avons mis en place un système de validation des retours négatifs par notre équipe d'administration. Seuls les retours qui respectent nos directives et qui sont constructifs seront publiés. Notre objectif est de créer un environnement sûr et utile pour tout le monde.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: darkColor)),
            SizedBox(height: 10.h),
            Image.asset(
              'assets/images/comment.png',
              height: 100.h,
            ),
            SizedBox(height: 10.h),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    text:
                        "Alors, que vous ayez une histoire positive à partager ou que vous souhaitiez mettre en garde les autres contre une expérience décevante, ",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: darkColor),
                    children: [
                      TextSpan(
                          text: "Wasal Soutek",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor)),
                      TextSpan(
                          text:
                              " est là pour vous. Rejoignez-nous et aidez-nous à construire une communauté où les voix de chacun comptent.!"),
                    ])),
                    SizedBox(height: 20.h),
                    RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "All rights reserved. Copyright © 2024 ",
                  style: TextStyle(fontSize: 16.sp, color: darkColor,fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text: "Wasal soutek",
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                  ])),
          ]),
        ),
      ),
    );
  }
}
