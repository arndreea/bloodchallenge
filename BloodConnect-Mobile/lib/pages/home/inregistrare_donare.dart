import 'package:blood_connect_mobile/pages/home/donation_registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InregistrareDonare extends StatelessWidget {
  final String id;
  final String token;
  final String donorId;
  final String time;

  const InregistrareDonare({Key? key, required this.id, required this.token, required this.donorId, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    DateTime appointment = DateTime.now();

    if (time != '')
      appointment = DateTime.parse(time);

    int diff = appointment
        .difference(currentTime)
        .inDays;
    print(diff);
    if (id != ' ' && currentTime.isAfter(appointment)) {
      return new Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // if you need this
              side: BorderSide(
                color: Colors.grey.withOpacity(0.6),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.bloodtype_rounded, color: Colors.pinkAccent,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                        child: Row(children: <Widget>[
                          Text("Inregistreaza-ti donarea",
                              style: new TextStyle(
                                fontSize: 15,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              )),
                          StatefulBuilder(
                              builder: (context, setState) =>
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DonationRegistrationScreen(
                                                        accesstoken: token,
                                                        donorId: donorId,
                                                        appointmentId: id)));
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: 17,
                                        color: Colors.black
                                      )))
                        ]),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
      );
    }


    else {
      return new Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // if you need this
              side: BorderSide(
                color: Colors.grey.withOpacity(0.6),
                width: 1,
              ),
            ),
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.bloodtype_rounded, color: Colors.black38,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                        child: Row(children: <Widget>[
                          Text("Inregistreaza-ti donarea",
                              style: new TextStyle(
                                fontSize: 15,
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              )),
                          StatefulBuilder(
                              builder: (context, setState) =>
                                  IconButton(
                                      onPressed: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             DonationRegistrationScreen(
                                        //                 accesstoken: token,
                                        //                 donorId: donorId,
                                        //                 appointmentId: id)));
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        size: 17,
                                        color: Colors.black38,
                                      )))
                        ]),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
      );
    }
  }
}