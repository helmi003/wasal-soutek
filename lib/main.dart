// ignore_for_file: prefer_const_constructors

import 'package:chihebapp2/Services/commentsProvider.dart';
import 'package:chihebapp2/Services/feedbackProvider.dart';
import 'package:chihebapp2/Services/userProvider.dart';
import 'package:chihebapp2/screens/home_screen.dart';
import 'package:chihebapp2/screens/loginWithEmail_screen.dart';
import 'package:chihebapp2/screens/login_screen.dart';
import 'package:chihebapp2/screens/spalsh_screen.dart';
import 'package:chihebapp2/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env").then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => FeedbackProvider()),
        ChangeNotifierProvider(create: (_) => CommentProvider()),
      ],
      child: MyApp(),
    ));
  }).catchError((error) {
    print("Error during initialization: $error");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(396, 642),
        builder: (context, child) {
          return MaterialApp(
            title: 'Wassal Soutek2',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(),
            home: SplashScreen(),
            routes: {
              LoginScreen.routeName: (ctx) => LoginScreen(),
              LoginWithEmailScreen.routeName: (ctx) => LoginWithEmailScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              TabScreen.routeName: (ctx) => TabScreen(),
            },
          );
        });
  }
}
