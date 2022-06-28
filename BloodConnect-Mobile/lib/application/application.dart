import 'package:blood_connect_mobile/pages/form/form_screen.dart';
import 'package:blood_connect_mobile/pages/home/home_screen.dart';
import 'package:blood_connect_mobile/pages/login/login_screen.dart';
import 'package:blood_connect_mobile/pages/profile/profile_screen.dart';
import 'package:blood_connect_mobile/pages/splash/splash_screen.dart';
import 'package:blood_connect_mobile/pages/home/donation_registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/donation/donation_history.dart';
import '../pages/info/info_screen.dart';
import '../pages/register/register_screen.dart';

class BloodConnectApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BloodConnectApp();
}

class _BloodConnectApp extends State<BloodConnectApp> {
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: new SplashScreen(),
     debugShowCheckedModeBanner: false,
     routes: <String, WidgetBuilder> {
       '/LoginScreen': (BuildContext context) => new LoginScreen(),
       '/RegisterScreen': (BuildContext context) => new RegisterScreen(),
     },
   );
  }
}