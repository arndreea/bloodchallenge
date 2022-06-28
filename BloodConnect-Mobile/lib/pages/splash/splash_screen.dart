import 'dart:async';

import 'package:blood_connect_mobile/resources/styles.dart';
import 'package:blood_connect_mobile/resources/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/LoginScreen');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Center(
      child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Strings.appName,
              style: Style.poppinsBoldTextStyleWith(fontSize: 30),
            ),
            SizedBox(height: 70),
            new Image.asset(
              'assets/images/logo.png',
              width: 100,
              height: 100,
            ),
            new Container(
              padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: new CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
