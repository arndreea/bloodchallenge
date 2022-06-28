import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:intl/intl.dart';
import '../../resources/texts.dart';
import '../core/ApiClient.dart';
import 'package:blood_connect_mobile/pages/model/donation.dart';

import '../model/donationdto.dart';
import '../model/user.dart';

class DonationHistoryScreen extends StatefulWidget {
  final String accesstoken;
  final User user;

  const DonationHistoryScreen ({Key? key, required this.user, required this.accesstoken}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _DonationHistoryScreen();
}

class _DonationHistoryScreen extends State<DonationHistoryScreen> {
  final form = GlobalKey<FormState>();

  final ApiClient _apiClient = ApiClient();

  Future<List<DonationDTO>> getUsersAppointments() async {
    return await _apiClient.getDonationsOfUser(widget.user.id, widget.accesstoken);
  }

  @override
  Widget build(BuildContext context) {
    //getUsersAppointments();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          elevation: .0,
          leading: BackButton(
              onPressed: () => Navigator.pop(context),
              color: Colors.white),
          title: Text(Strings.drawer_donation_history),
        ),
        body:
            Container(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<List<DonationDTO>>(
                  future: getUsersAppointments(),
                  //initialData: AppointmentRes2,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData || snapshot.hasError || snapshot.data == [] || snapshot.data.length == 0) {
                      //doesn't catch if a donor has no donations, so it doesn't show anything
                      //Image.asset("assets/images/donation3.png", scale: 0.4),
                      return Center(
                          child:Container(
                        height: 479,
                          color: Colors.transparent,
                          child:Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // if you need this
                              side: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                            child:
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child:Column(
                                        children: [
                                          Padding(
                                          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                                          child: Row(children: <Widget>[
                                            Text("Nu aveți donări înregistrate.",
                                                style: new TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.pink,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ]
                                          ),
                                        ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                                            child: Row(children: <Widget>[
                                              Icon(Icons.self_improvement_rounded, color: Colors.black,),
                                              Text("     Consultați pagina de informații pentru\n     a putea afla cum puteți salva vieți\n     printr-o donare de sânge.",
                                                  style: new TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),softWrap: true,
                                              ),
                                            ]
                                            ),
                                          ),
                                          Image.asset("assets/images/donation3.png", scale: 0.2),
                                    ],
                              ),
                          ),
                      ),),);
                    } else {
                      //print(snapshot.data!);
                      return Container(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                //print(snapshot.data.length);
                                if(snapshot.hasData && snapshot.data.length>0) {
                                  var data = snapshot.data[index];
                                  var appointmentDate = data.appointmentDate;
                                  var location = data.location.substring(31);
                                  var mana = data.mana;
                                  var tip = data.tip;
                                  return
                                    Container(
                                      child:Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20), // if you need this
                                        side: BorderSide(
                                          color: Colors.grey.withOpacity(0.6),
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child:Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                                                child: Row(children: <Widget>[
                                                  Icon(Icons.calendar_today_sharp, color: Colors.pink,),
                                                  Text("     ${DateFormat('dd/MM/yyyy').format(DateTime.parse(appointmentDate)).toString()}",
                                                      style: new TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.pink,
                                                        fontWeight: FontWeight.bold,
                                                      )
                                                  ),
                                                ]
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                                                child: Row(children: <Widget>[
                                                  Icon(Icons.location_on, color: Colors.black,),
                                                  Text("     Centrul de Transfuzie Sanguină\n     $location",
                                                      style: new TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )
                                                  ),
                                                ]
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                                                child: Row(children: <Widget>[
                                                  Icon(Icons.bloodtype, color: Colors.black,),
                                                  Text("     $tip",
                                                      style: new TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )
                                                  ),
                                                ]
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                                                child: Row(children: <Widget>[
                                                  Icon(Icons.front_hand, color: Colors.black,),
                                                  Text("     $mana",
                                                      style: new TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      )
                                                  ),
                                                ]
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child:Container(
                                    height: 479,
                                    color: Colors.transparent,
                                    child:Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20), // if you need this
                                        side: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                      child:
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child:Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                                              child: Row(children: <Widget>[
                                                Text("Nu aveți donări înregistrate.",
                                                  style: new TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.pink,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ]
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 20),
                                              child: Row(children: <Widget>[
                                                Icon(Icons.self_improvement_rounded, color: Colors.black,),
                                                Text("     Consultați pagina de informații pentru\n     a putea afla cum puteți salva vieți\n     printr-o donare de sânge.",
                                                  style: new TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),softWrap: true,
                                                ),
                                              ]
                                              ),
                                            ),
                                            Image.asset("assets/images/donation3.png", scale: 0.2),
                                          ],
                                        ),
                                      ),
                                    ),),);
                                }
                              }
                          )
                      );
                    }
                  }
            ),
        ),
      ),
    );
  }
}
