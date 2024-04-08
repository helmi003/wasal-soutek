// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:chihebapp2/Services/userProvider.dart';
import 'package:chihebapp2/screens/home_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/errorMessage.dart';
import 'package:chihebapp2/widgets/iconButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Image.asset(
              'assets/images/logo_name.png',
              height: 140.h,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Faites-nous part de vos expériences négatives : arnaques en ligne, publicités trompeuses, produits de qualité inférieure... Nous sommes là pour vous aider à faire valoir vos droits et à prendre des mesures contre ces pratiques abusives',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: darkColor),
              ),
            ),
            SizedBox(height: 40.h),
            Center(
                child: IconButtonWidget(
              'Continue avec facebook',
              FontAwesomeIcons.facebook,
              false,
              () {
                login();
              },
            ))
          ],
        ),
      ),
    );
  }

  login() async {
    final url = dotenv.env['API_URL'];
    if (!await launchUrl(Uri.parse("$url/user/auth/facebook"))) {
      throw Exception('Could not launch $url');
    } else {
      // ErrorMessage('Alert', 'an error', redColor);
    }
    // setState(() {
    //   isLoading = true;
    // });
    // try {
    //   await context.read<UserProvider>().login();
    //   Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    // } catch (onError) {
    //   showDialog(
    //     context: context,
    //     builder: ((context) {
    //       return ErrorMessage(
    //         "Alert",
    //         onError.toString(),
    //         redColor,
    //       );
    //     }),
    //   );
    // } finally {
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }
}
