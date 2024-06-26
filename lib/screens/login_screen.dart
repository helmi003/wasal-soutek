// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:chihebapp2/Services/userProvider.dart';
import 'package:chihebapp2/screens/home_screen.dart';
import 'package:chihebapp2/screens/register_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/buttonWidget.dart';
import 'package:chihebapp2/widgets/errorPopUp.dart';
import 'package:chihebapp2/widgets/passwordFieldWidget.dart';
import 'package:chihebapp2/widgets/textFieldWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailError = "";
  String passwordError = "";
  bool isLoading = false;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Image.asset(
                'assets/images/logo_name.png',
                height: 140.h,
              ),
              SizedBox(height: 10.h),
              Text(
                "Créez votre compte",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: darkColor),
              ),
              SizedBox(height: 20.h),
              TextFieldWidget(
                  emailController, 'E-mail ou numéro de téléphone', emailError),
              PasswordFieldWidget(passwordController, 'Mot de passe',
                  passwordError, obscureText, hideText),
              SizedBox(height: 30.h),
              ButtonWidget(login, 'Se connectez', isLoading),
              SizedBox(height: 10.h),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: "Vous n'avez pas de compte ? ",
                      children: [
                        TextSpan(
                          text: "S'inscrire",
                          style: TextStyle(
                              color: redColor, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                        )
                      ],
                      style: TextStyle(
                        fontSize: 16,
                        color: darkColor,
                      )),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  hideText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<void> login() async {
    if (emailController.text == "") {
      setState(() {
        emailError = "Ce champ est obligatoire";
        passwordError = "";
      });
    } else if (passwordController.text == "") {
      setState(() {
        emailError = "";
        passwordError = "Ce champ est obligatoire";
      });
    } else {
      setState(() {
        isLoading = true;
        emailError = "";
        passwordError = "";
      });
      try {
        await context
            .read<UserProvider>()
            .login(emailController.text, passwordController.text)
            .then((value) {
          setState(() {
            emailController.clear();
            passwordController.clear();
          });
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        });
      } catch (onError) {
        showDialog(
          context: context,
          builder: ((context) {
            return ErrorPopUp("Alert", onError.toString(), redColor);
          }),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
