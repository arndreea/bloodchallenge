import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/appointment.dart';

class ProgramareActiva extends StatelessWidget {
    final String id;
    final String date;
    final String location;
  const ProgramareActiva({Key? key, required this.id, required this.date, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("car " + id);
    if (id != '') {
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
            child: Row(children: <Widget>[
              Icon(
                Icons.fact_check,
                color: Colors.pinkAccent,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                    child: Row(children: <Widget>[
                      Text("Programare activă",
                          style: new TextStyle(
                            fontSize: 15,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                          )),
                    ]),
                  ),
                  //Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 4.0, left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today_sharp),
                        Text(" " + date)
                        // Text(
                        //     "${DateFormat('dd/MM/yyyy')
                        //         .format(DateTime.now())
                        //         .toString()}"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 4.0, left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        Text(" " + location),
                      ],
                    ),
                  ),
                ],
              ),
              // Spacer(),
            ]
            ),
          ),
        ),
      );
    }
  else{
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
          child: Row(children: <Widget>[
          Icon(
          Icons.fact_check,
          color: Colors.black38,
          ),
          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Padding(
          padding:
          const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
          child: Row(children: <Widget>[
          Text("Programare activă",
          style: new TextStyle(
    fontSize: 15,
    color: Colors.black38,
    fontWeight: FontWeight.bold,
    )),
    ]),
    ),
    //Spacer(),
    Padding(
    padding: const EdgeInsets.only(
    top: 8.0, bottom: 4.0, left: 20.0),
    child: Row(
    children: <Widget>[
    Icon(Icons.calendar_today_sharp, color: Colors.black38,),
    Text(
    ""),
    ],
    ),
    ),
    Padding(
    padding: const EdgeInsets.only(
    top: 8.0, bottom: 4.0, left: 20.0),
    child: Row(
    children: <Widget>[
    Icon(Icons.location_on, color: Colors.black38,),
    Text(""),
    ],
    ),
    ),
    ],
    ),
    // Spacer(),
    ]
    ),
    ),
    ),
    );
    }
    }
    }



