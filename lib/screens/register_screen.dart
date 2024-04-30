// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:chihebapp2/Services/userProvider.dart';
import 'package:chihebapp2/screens/login_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/buttonWidget.dart';
import 'package:chihebapp2/widgets/errorPopUp.dart';
import 'package:chihebapp2/widgets/passwordFieldWidget.dart';
import 'package:chihebapp2/widgets/textFieldWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/RegisterScreen";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String displayNameError = "";
  String emailError = "";
  String passwordError = "";
  String confirmPasswordError = "";
  bool isLoading = false;
  bool obscureText = true;
  bool obscureText2 = true;
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
                  displayNameController, 'Nom et prénom', displayNameError),
              TextFieldWidget(
                  emailController, 'E-mail ou numéro de téléphone', emailError),
              PasswordFieldWidget(passwordController, 'Mot de passe',
                  passwordError, obscureText, hideText),
              PasswordFieldWidget(
                  confirmPasswordController,
                  'Confirmez le mot de passe',
                  confirmPasswordError,
                  obscureText2,
                  hideText2),
              SizedBox(height: 10.h),
              ButtonWidget(register, "S'inscrire", isLoading),
              SizedBox(height: 10.h),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: "Vous avez déjà un compte ? ",
                      children: [
                        TextSpan(
                          text: "Se connecter",
                          style: TextStyle(
                              color: redColor, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
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

  hideText2() {
    setState(() {
      obscureText2 = !obscureText2;
    });
  }

  Future<void> register() async {
    if (displayNameController.text == "") {
      setState(() {
        displayNameError = "Ce champ est obligatoire";
        emailError = "";
        passwordError = "";
        confirmPasswordError = "";
      });
    } else if (emailController.text == "") {
      setState(() {
        displayNameError = "";
        emailError = "Ce champ est obligatoire";
        passwordError = "";
        confirmPasswordError = "";
      });
    } else if (passwordController.text == "") {
      setState(() {
        displayNameError = "";
        emailError = "";
        passwordError = "Ce champ est obligatoire";
        confirmPasswordError = "";
      });
    } else if (confirmPasswordController.text == "") {
      setState(() {
        displayNameError = "";
        emailError = "";
        passwordError = "";
        confirmPasswordError = "Ce champ est obligatoire";
      });
    } else if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        displayNameError = "";
        emailError = "";
        passwordError = "";
        confirmPasswordError = "Le mot de passe ne correspondent pas";
      });
    } else {
      setState(() {
        isLoading = true;
        displayNameError = "";
        emailError = "";
        passwordError = "";
        confirmPasswordError = "";
      });
      try {
        await context
            .read<UserProvider>()
            .register(displayNameController.text, emailController.text,
                passwordController.text)
            .then((value) {
          setState(() {
            emailController.clear();
            passwordController.clear();
            confirmPasswordController.clear();
          });
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
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
