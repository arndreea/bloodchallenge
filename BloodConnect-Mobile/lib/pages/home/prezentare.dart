import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Prezentare extends StatelessWidget {
  final String id;
  final String date;
  final String location;

  Prezentare({Key? key, required this.id, required this.date, required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    DateTime appointment = DateTime.now();
    if (date != '')
      appointment = DateTime.parse(date
          .split(' ')
          .first);

    int diff = appointment
        .difference(currentTime)
        .inDays;
    print(diff);
    if (id != '' && diff == 0) {
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
              Icon(Icons.location_on, color: Colors.pinkAccent),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                    child: Row(children: <Widget>[
                      Text("Prezentare la centrul de transfuzii",
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
                        Text(" " + date),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        Text(" " + location),
                      ],
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.only(bottom: 4.0, left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildText(
                              "\nÎn ziua donării este obligatoriu să luați micul \ndejun și să fi consumat 800-1000ml de lichide\n\nVă prezentați la centru, anunțați programarea\nla fisier, primiți un număr preferentil și nu mai\n"
                                  "stați la rând"),
                          TextButton(
                              onPressed: () {
                                isReadmore = !isReadmore;
                                (context as Element).markNeedsBuild();
                              },
                              child: Text(
                                (isReadmore
                                    ? 'Vezi mai puțin' : 'Vezi detalii'),
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black38),
                              ))
                        ],
                      )),
                ],
              ),
              // Spacer(),
            ]),
          ),
        ),
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
            child: Row(children: <Widget>[
              Icon(Icons.location_on, color: Colors.black38),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                    child: Row(children: <Widget>[
                      Text("Prezentare la centrul de transfuzii",
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
                    padding: const EdgeInsets.only(top: 8.0, left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.black38,),
                        Text(""),
                      ],
                    ),
                  ),

                  Padding(
                      padding: const EdgeInsets.only(bottom: 4.0, left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildText(
                              "\nÎn ziua donării este obligatoriu să luați micul \ndejun și să fi consumat 800-1000ml de lichide\n\nVă prezentați la centru, anunțați programarea\nla fisier, primiți un număr preferentil și nu mai\n"
                                  "stați la rând"),
                          TextButton(
                              onPressed: () {
                               // isReadmore = !isReadmore;
                               // (context as Element).markNeedsBuild();
                              },
                              child: Text(
                                (isReadmore
                                    ? 'Vezi mai puțin' : 'Vezi detalii'),
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black38),
                              ))
                        ],
                      )),
                ],
              ),
              // Spacer(),
            ]),
          ),
        ),
      );
    }
  }

  bool isReadmore = false;

  Widget buildText(String text) {
    final lines = isReadmore ? null : 1;
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 15),
        maxLines: lines,
        overflow: isReadmore ? TextOverflow.visible : TextOverflow.ellipsis,
      ),
      width: 300,
    );
  }

}