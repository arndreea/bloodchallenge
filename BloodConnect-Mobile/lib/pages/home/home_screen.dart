
import 'dart:async';

import 'package:blood_connect_mobile/common/widgets/welcome_card_widget.dart';
import 'package:blood_connect_mobile/pages/home/inregistrare_donare.dart';
import 'package:blood_connect_mobile/pages/home/pregatire_programare.dart';
import 'package:blood_connect_mobile/pages/home/prezentare.dart';
import 'package:blood_connect_mobile/pages/home/programare_activa.dart';
import 'package:blood_connect_mobile/pages/model/appointment.dart';
import 'package:blood_connect_mobile/pages/profile/profile_screen.dart';
import 'package:blood_connect_mobile/resources/texts.dart';
import 'package:blood_connect_mobile/pages/home/donation_registration.dart';
import 'package:blood_connect_mobile/pages/core/ApiClient.dart';
import 'package:blood_connect_mobile/pages/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../appointment/appointment_screen.dart';
import '../donation/donation_history.dart';
import '../form/form_screen.dart';
import '../info/info_screen.dart';
import '../login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String accesstoken;
  final User user;
 // final Appointment appointment;

  const HomeScreen({Key? key, required this.accesstoken, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final form = GlobalKey<FormState>();
  final ApiClient _apiClient = ApiClient();

  late Future<void> inFuture;

  //todo figure out timer that gets initalized way too many times when i switch pages
  late Timer timer;

  // Appointment appointment = new Appointment(id: '',
  //     donorID: '',
  //     location: '',
  //     appointmentDate: '',
  //     isActive: '');

  Future<Appointment> getAppointment() async {
    // Response res;

    String id = widget.user.id;
    //print(id);
    return await _apiClient.getAppointmentByDonorId(id, widget.accesstoken);
  }

  late Future<void> _value;

  @override
  void initState() {
    //WidgetsBinding.instance!.addObserver(this);
    super.initState();
    //_value = getAppointment();
    timer = Timer.periodic(Duration(seconds: 60), (Timer t) => {setState(() {_value = getAppointment();})});
  }

  void initTimer(){
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => {setState(() {_value = getAppointment();})});
  }

  bool isCheckedBlood = false;
  bool isCheckedAfereza = false;
  bool isCheckedRight = false;
  bool isCheckedLeft = false;

  String? tipDonare;
  String? hand;

  @override
  Widget build(BuildContext context) {
    //getAppointment();
    //print(appointment.id);
    // Appointment appointment = new Appointment(id: '',
    //     donorID: '',
    //     location: '',
    //     appointmentDate: '',
    //     isActive: '');
    return FutureBuilder<Appointment>(
        future: getAppointment(),
        builder: (context, AsyncSnapshot<Appointment> snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      elevation: .0,
                      backgroundColor: Colors.pink,
                      title: Text("BloodConnect"),
                    ),
                    drawer: Drawer(
                      child: ListView(
                        children: <Widget>[
                          UserAccountsDrawerHeader(
                            accountName: Text(widget.user.firstName + " " +
                                widget.user.lastName),
                            accountEmail: Text(widget.user.email),
                            decoration: BoxDecoration(color: Colors.pink),
                            currentAccountPicture: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1627498290041-a4851897dcda?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=875'),
                            ),
                            otherAccountsPictures: <Widget>[],
                          ),
                          ListTile(
                            title: Text(Strings.drawer_menu_schedule),
                            trailing: Icon(Icons.watch_later),
                            onLongPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AppointmentScreen(
                                              accesToken: widget.accesstoken, user: widget.user, id: snapshot.data!.id)));
                            },
                          ),
                          Divider(),
                          ListTile(
                            title: Text(Strings.drawer_my_profile),
                            trailing: Icon(Icons.person),
                            onLongPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileScreen(user: widget.user)));
                            },
                          ),
                          Divider(),
                          ListTile(
                            title: Text(Strings.drawer_donation_history),
                            trailing: Icon(Icons.history_sharp),
                            onLongPress: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => DonationHistoryScreen(user: widget.user, accesstoken: widget.accesstoken)));
                            },
                          ),
                          Divider(),
                          ListTile(
                            title: Text(Strings.drawer_donation_info),
                            trailing: Icon(Icons.info),
                            onLongPress: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoScreen()));
                            },
                          ),
                          Divider(),
                          ListTile(
                            title: Text(Strings.drawer_donation_eligibility),
                            trailing: Icon(Icons.assignment_outlined),
                            onLongPress: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => FormScreen(user: widget.user, accesstoken: widget.accesstoken)));
                            },
                          ),
                          Divider(),
                          ListTile(
                            title: Text(Strings.drawer_log_out),
                            trailing: Icon(Icons.close),
                            onTap: () {
                              timer.cancel();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                            },
                          ),
                        ],
                      ),
                    ),
                    body: ListView(
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(12.0),
                        children: [
                          ProgramareActiva(id: snapshot.data!.id,
                            date: snapshot.data!.appointmentDate.toString(),
                            location: snapshot.data!.location,),
                          PregatireProgramare(id: snapshot.data!.id,
                          date: snapshot.data!.appointmentDate.toString(),),
                          Prezentare(id: snapshot.data!.id,
                              date: snapshot.data!.appointmentDate.toString(),
                              location: snapshot.data!.location,),
                          InregistrareDonare(id: snapshot.data!.id,
                              token: widget.accesstoken,
                              donorId: widget.user.id.toString(),
                          time: snapshot.data!.appointmentDate)
                        ])
                ));
          }
          else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}