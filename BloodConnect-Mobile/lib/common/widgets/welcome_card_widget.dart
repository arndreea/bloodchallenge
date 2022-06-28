import 'package:blood_connect_mobile/resources/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  final String message;

  WelcomeCard(this.message);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: Style.poppinsBoldTextStyleWith(
                fontSize: 20, color: Colors.purple
              ),
            )
          ],
        ),
      ),
    );
  }
}