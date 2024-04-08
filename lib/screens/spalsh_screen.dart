// ignore_for_file: use_key_in_widget_constructors, use_build_context_synchronously

import 'package:chihebapp2/Services/userProvider.dart';
import 'package:chihebapp2/screens/home_screen.dart';
import 'package:chihebapp2/screens/login_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/errorMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: true);

  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        try {
          bool isLoggedIn = await context.read<UserProvider>().tryAutoLogin();
          if (isLoggedIn) {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          } else {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }
        } catch (e) {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          showDialog(
              context: context,
              builder: ((context) {
                return ErrorMessage(
                  "Alert",
                  e.toString(),
                  redColor,
                );
              }));
        }
      }
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: ScaleTransition(
        scale: _animation,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Image.asset(
              'assets/images/logo_name.png',
            ),
          ),
        ),
      ),
    );
  }
}
