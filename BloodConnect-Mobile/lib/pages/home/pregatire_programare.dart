import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PregatireProgramare extends StatelessWidget {
  final String id;
  final String date;

   PregatireProgramare({Key? key, required this.id, required this.date}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    DateTime appointment = DateTime.now();
    if(date != '')
      appointment = DateTime.parse(date.split(' ').first);

    int diff = appointment.difference(currentTime).inDays;
    print(diff);
    if (id != '' && diff < 2) {
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
                Icons.apple_rounded,
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
                      Text(
                        "Pregatire pentru programare",
                        style: new TextStyle(
                          fontSize: 15,
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                  //Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today_sharp),
                        Text(" " + date
                            ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0, left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildText(
                            "\n??nainte cu 48h de a dona s??nge, va recomand??m s?? va hidradati cu un minim de 2l de ap?? ??i s?? ave??i o alimenta??ie s??n??toas??."),
                        TextButton(
                            onPressed: () {
                              isReadmore = !isReadmore;
                              (context as Element).markNeedsBuild();
                            },
                            child: Text(
                              (isReadmore ? 'Vezi mai pu??in' : 'Vezi detalii'),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black38),
                            ))
                      ],
                    ),
                  ),
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
              Icon(
                Icons.apple_rounded,
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
                      Text(
                        "Pregatire pentru programare",
                        style: new TextStyle(
                          fontSize: 15,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ),
                  //Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today_sharp, color: Colors.black38,),
                        Text(
                            ''),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0, left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildText(
                            "\n??nainte cu 48h de a dona s??nge, v?? recomand??m s?? v?? hidradati cu un minim de 2l de ap?? ??i s?? ave??i o alimenta??ie s??n??toas??."),
                        TextButton(
                            onPressed: () {
                              // isReadmore = !isReadmore;
                              // (context as Element).markNeedsBuild();
                            },
                            child: Text(
                              (isReadmore ? 'Vezi mai pu??in' : 'Vezi detalii'),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black38),
                            ))
                      ],
                    ),
                  ),
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