import 'package:flutter/material.dart';

import '../../common/widgets/appointment_form_widget.dart';
import '../../resources/texts.dart';
import '../model/appointment.dart';
import '../model/user.dart';

class AppointmentScreen extends StatefulWidget {
  final String accesToken;
  final User user;
  final String id;

  @override
  State<StatefulWidget> createState() => new _AppointmentScreen();

  const AppointmentScreen({Key? key, required this.accesToken, required this.user, required this.id}) : super(key: key);
}

class _AppointmentScreen extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: .0,
          backgroundColor: Colors.pink,
          title: Text(Strings.drawer_menu_schedule),
        ),
        body: AppointmentForm(accesToken: widget.accesToken, user: widget.user, id: widget.id,),
      ),
    );
  }
}
