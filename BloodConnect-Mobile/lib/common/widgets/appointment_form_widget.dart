import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// import 'package:get/get_connect/http/src/response/response.dart';
import 'package:intl/intl.dart';

import '../../pages/core/ApiClient.dart';
import '../../pages/home/home_screen.dart';
import '../../pages/model/appointment.dart';
import '../../pages/model/user.dart';
import '../../resources/texts.dart';
import 'date_picker_widget.dart';

class AppointmentForm extends StatefulWidget {
  final String accesToken;
  final User user;
  final String id;

  const AppointmentForm({Key? key, required this.accesToken, required this.user, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _AppointmentForm();
}

class _AppointmentForm extends State<AppointmentForm> {
  initState() {
    return super.initState();
  }

  final ApiClient _apiClient = ApiClient();

  DateTime selectedDate = DateTime.now();

  DateTime selectedDateFinal = DateTime.now();

  TimeOfDay _time = TimeOfDay(hour: 8, minute: 0);

  String? _selectedLocation;

  List<String> transfusionCenters = [
    'Centrul de Transfuzie Sanguină Cluj-Napoca',
    'Centrul de Transfuzie Sanguină Oradea',
    'Centrul de Transfuzie Sanguină Zalau',
    'Centrul de Transfuzie Sanguină Alba-Iulia',
    'Centrul de Transfuzie Sanguină Bistrita-Nasaud',
    'Centrul de Transfuzie Sanguină Baia Mare',
    'Centrul de Transfuzie Sanguină Pitesti',
    'Centrul de Transfuzie Sanguină Bucuresti'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              // drop down transfusion centers
              DropdownButton<String>(
                dropdownColor: Colors.white,
                hint: Text(Strings.schedule_appointment_drop_down_default),
                value: _selectedLocation,
                icon: const Icon(Icons.pin_drop),
                iconSize: 24,
                elevation: 16,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLocation = newValue ?? "";
                    print(_selectedLocation);
                  });
                },
                items: transfusionCenters
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ), // date picker appointment date
              SizedBox(height: 30),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text(Strings.schedule_appointment_choose_a_date),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink, // This is what you need!
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Data selectata: " +
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        _selectHour(context);
                      },
                      child: Text(Strings.schedule_appointment_choose_an_hour),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink, // This is what you need!
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    Text("Ora selectata: " + "$_time"),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        _saveAppointment(context);
                      },
                      child: Text(Strings.schedule_appointment_save),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink, // This is what you need!
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.pink, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.pink, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  void _selectHour(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.pink, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.pink, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        print(_time);
        selectedDateFinal = new DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, _time.hour, _time.minute);
        print("Data finala: " + selectedDate.toString());
      });
    }
  }

  Future<void> _saveAppointment(BuildContext context) async {
    final String pattern = 'yyyy-MM-dd HH:mm';
    final String formatted = DateFormat(pattern).format(selectedDateFinal);
    print(formatted);
    //validation0 : not empty data
    print(_selectedLocation);
    print(formatted);
    print(selectedDateFinal);
    print(DateTime.now());
    if((selectedDateFinal.isAfter(DateTime.now().subtract(const Duration(minutes: 1))) && selectedDateFinal.isBefore(DateTime.now())) || _selectedLocation == null) {
      showDialog(context: context, builder: (BuildContext context) => _invalidDataPopupDialog(context));
      return;
    }
    //validation1 : no active appointment active
    if(widget.id != '') {
      showDialog(context: context, builder: (BuildContext context) => _activeAppointmentPopupDialog(context));
      return;
    }
    //validation2 : date checker
    if(selectedDateFinal.isBefore(DateTime.now().subtract(const Duration(seconds: 1)))) {
      showDialog(context: context, builder: (BuildContext context) => _invalidDatePopupDialog(context));
      return;
    }
    //validation3 : isPotentialDonor true
    if(widget.user.isPotentialDonor == 'false') {
      showDialog(context: context, builder: (BuildContext context) => _invalidPotentialDonorPopupDialog(context));
      return;
    }
    Response res = await _apiClient.saveAppointment(
        widget.accesToken, _selectedLocation!, formatted, true);
    //print(res);
    if (res.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context),
      );
    }
  }

  _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Felicitări!', style: TextStyle(color: Colors.pink)),
      content: Text('Programare efectuata cu succes!',
          style: TextStyle(color: Colors.black)),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>
                    HomeScreen(
                      accesstoken: widget.accesToken, user: widget.user,)));
          },
          child: const Text('Înapoi la pagina principală',
              style: TextStyle(color: Colors.pink)),
        ),
      ],
    );
  }

  _invalidPotentialDonorPopupDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Ne pare rău!', style: TextStyle(color: Colors.pink)),
      content: Text('Din păcate, momentan, nu sunteți apt pentru donare! Completați formularul să aflați dacă sunteți de fapt eligibil.', style: TextStyle(color: Colors.black)),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen(accesstoken: widget.accesToken, user: widget.user,)));
            },
            child: const Text('Înapoi la pagina principală', style: TextStyle(color: Colors.pink)),
          ),
        ],
      );
  }

  _invalidDatePopupDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Ne pare rău!', style: TextStyle(color: Colors.pink)),
      content: Text('Nu puteți face o programare în trecut!', style: TextStyle(color: Colors.black)),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen(accesstoken: widget.accesToken, user: widget.user,)));
          },
          child: const Text('Înapoi la pagina principală', style: TextStyle(color: Colors.pink)),
        ),
      ],
    );
  }

  _invalidDataPopupDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Date incomplete!', style: TextStyle(color: Colors.pink)),
      content: Text('Completați toate câmpurile pentru a vă programa!', style: TextStyle(color: Colors.black)),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Închide', style: TextStyle(color: Colors.pink)),
        ),
      ],
    );
  }

  _activeAppointmentPopupDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Ne pare rău!', style: TextStyle(color: Colors.pink)),
      content: Text('Deja aveți o programare activă.', style: TextStyle(color: Colors.black)),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen(accesstoken: widget.accesToken, user: widget.user,)));
          },
          child: const Text('Înapoi la pagina principală', style: TextStyle(color: Colors.pink)),
        ),
      ],
    );
  }
}
