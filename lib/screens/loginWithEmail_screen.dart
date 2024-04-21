// ignore_for_file: use_build_context_synchronously

import 'package:chihebapp2/Services/userProvider.dart';
import 'package:chihebapp2/screens/home_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/buttonWidget.dart';
import 'package:chihebapp2/widgets/errorPopUp.dart';
import 'package:chihebapp2/widgets/passwordFieldWidget.dart';
import 'package:chihebapp2/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class LoginWithEmailScreen extends StatefulWidget {
  static const routeName = "/LoginWithEmailScreen";
  const LoginWithEmailScreen({super.key});

  @override
  State<LoginWithEmailScreen> createState() => _LoginWithEmailScreenState();
}

class _LoginWithEmailScreenState extends State<LoginWithEmailScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailError = "";
  String passwordError = "";
  bool isLoading = false;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Image.asset(
                'assets/images/logo_name.png',
                height: 140.h,
              ),
              SizedBox(height: 10.h),
              TextFieldWidget(emailController, 'E-mail', emailError),
              PasswordFieldWidget(passwordController, 'Mot de passe',
                  passwordError, obscureText, hideText),
              ButtonWidget(login, 'Se connectez', isLoading)
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
    } else if (!EmailValidator.validate(emailController.text)) {
      setState(() {
        emailError = "Ce n'est pas un email correct";
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
            .login(emailController.text, passwordController.text);
        setState(() {
          emailController.text = "";
          passwordController.text = "";
        });
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
