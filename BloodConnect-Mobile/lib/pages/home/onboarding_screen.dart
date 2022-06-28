
import 'package:blood_connect_mobile/pages/home/home_screen.dart';
import 'package:blood_connect_mobile/pages/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_onboarding_screen/OnbordingData.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../model/appointment.dart';

class OnboardingScreen extends StatefulWidget {

  final String accesstoken;
  final User user;


  const OnboardingScreen({Key? key, required this.accesstoken, required this.user}) : super(key: key);


  @override
  State<StatefulWidget> createState() => new _OnboardingState();
}

class _OnboardingState extends State<OnboardingScreen> {

  final List<PageViewModel> list = [

    PageViewModel(
      image: Image.asset("assets/images/donation1.png", scale: 0.4,),
      title: "Donarea de sange",
      body:"Actul donării de sânge are puterea de a salva vieți omenești, aducând în același timp beneficii asupra stării de sănătate a donatorului. Nevoia de sânge este una permanentă și apare în situații precum:tratarea bolnavilor de cancer, intervenții chirurgicale, transplante, etc. Cu un procent de sub ~2%,România ocupă ultimele locuri în ceea ce privește numărul de donatori de sânge în clasamentul european",

        decoration: const PageDecoration(
          bodyTextStyle: TextStyle(fontSize: 14, color: Colors.black)
        )
    ),
    PageViewModel(
      image: Image.asset("assets/images/donation2.png", scale: 0.4),
      title: "Hai la donare!",
      bodyWidget: Text("Fa parte din schimbare si hai la donare! Utilizeaza aplicatia pentru a avea la indemana traseul donatorului de sange si o evidenta a propriilor donari", style: TextStyle(
          fontSize: 16, color: Colors.black
      ),),
        decoration: const PageDecoration(
            bodyTextStyle: TextStyle(fontSize: 20, color: Colors.black),

        )
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
        pages:list,
      showNextButton: false,
      showBackButton: false,
      showSkipButton: true,
      skip: const Text("Skip"),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        onSkip: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(accesstoken: widget.accesstoken, user: widget.user,)));
        },
        onDone : () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(accesstoken: widget.accesstoken, user: widget.user,)));
        },



    );
  }
}