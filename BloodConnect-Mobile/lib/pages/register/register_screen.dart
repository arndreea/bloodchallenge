//import 'dart:html';
import 'package:blood_connect_mobile/pages/core/ApiClient.dart';
import 'package:blood_connect_mobile/pages/home/home_screen.dart';
import 'package:blood_connect_mobile/utils/validators.dart';
import 'package:blood_connect_mobile/pages/model/user.dart';
import 'package:blood_connect_mobile/pages/model/appointment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController kilogramsController = TextEditingController();
  TextEditingController bloodPressureController = TextEditingController();
  String bloodType = "";
  String rh = "";
  String birth_date = "";
  DateTime? _dateTime;
  String dropdownValueBloodtype = 'O';
  String dropdownValueRh = 'Negative';
  late Color color;

  late TextStyle labelStyle;

  late FocusNode focusNodeNume = new FocusNode();
  late FocusNode focusNodePrenume = new FocusNode();
  late FocusNode focusNodeTelefon = new FocusNode();
  late FocusNode focusNodeEmail = new FocusNode();
  late FocusNode focusNodeParola = new FocusNode();
  late FocusNode focusNodeInaltime = new FocusNode();
  late FocusNode focusNodeKilograme = new FocusNode();
  late FocusNode focusNodeTensiune = new FocusNode();


  final ApiClient _apiClient = ApiClient();

  User user = new User(
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      kilograms: '',
      bloodPressure: '',
      rh: '',
      birthdate: '',
      isPotentialDonor: '',
      bloodType: '',
      height: '');

  String token ="";

  @override
  Widget build(BuildContext context){
    return new Scaffold(appBar: AppBar(
      title: Text("Register"),
      backgroundColor: Colors.pink,
    ),resizeToAvoidBottomInset:true,
        body:Form(
        //padding:new Padding(padding: const EdgeInsets.all(10),
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        child:SingleChildScrollView(
        child:Stack(
           // padding: Padding(padding: const  EdgeInsets.all(10)),
         // key: _formKey,
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: TextFormField(
                  focusNode: focusNodePrenume,
                  autovalidateMode :AutovalidateMode.onUserInteraction,
                  validator: (value) => Validator.validateFirstName(value ?? ""),
                  controller: first_nameController,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: 'Introdu prenumele tău',
                    labelText: 'Prenume',
                    focusColor: Colors.pink,
                    iconColor: Colors.pink,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: TextFormField(
                  focusNode: focusNodeNume,
                  autovalidateMode :AutovalidateMode.onUserInteraction,
                  validator: (value) => Validator.validateLastName(value ?? ""),
                  controller: last_nameController,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: 'Introdu numele tău',
                    labelText: 'Nume',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: TextFormField(
                  focusNode: focusNodeTelefon,
                  autovalidateMode :AutovalidateMode.onUserInteraction,
                  validator: (value) => Validator.validatePhoneNumber(value ?? ""),
                  controller: phoneController,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.phone),
                    hintText: 'Introdu numărul tău de telefon',
                    labelText: 'Număr telefon',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: TextFormField(
                  focusNode: focusNodeEmail,
                  autovalidateMode :AutovalidateMode.onUserInteraction,
                  validator: (value) => Validator.validateEmail(value ?? ""),
                  controller: emailController,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.email),
                    hintText: 'Introdu email-ul tău',
                    labelText: 'Email',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: TextFormField(
                  focusNode: focusNodeParola,
                  autovalidateMode :AutovalidateMode.onUserInteraction,
                  validator: (value) => Validator.validatePassword(value ?? ""),
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.password),
                    hintText: 'Introdu parola',
                    labelText: 'Parolă',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: TextFormField(
                  focusNode: focusNodeInaltime,
                  autovalidateMode :AutovalidateMode.onUserInteraction,
                  validator: (value) => Validator.validateHeight(value ?? ""),
                  controller: heightController,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.height),
                    hintText: 'Introdu înălțimea',
                    labelText: 'Înălțime',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: TextFormField(
                  focusNode: focusNodeKilograme,
                  autovalidateMode :AutovalidateMode.onUserInteraction,
                  validator: (value) => Validator.validateKilograms(value ?? ""),
                  controller: kilogramsController,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.keyboard_arrow_right),
                    hintText: 'Introdu greutatea ta',
                    labelText: 'Kilograme',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: TextFormField(
                  focusNode: focusNodeTensiune,
                  autovalidateMode :AutovalidateMode.onUserInteraction,
                  validator: (value) => Validator.validateBloodPressure(value ?? ""),
                  controller: bloodPressureController,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.keyboard_arrow_right),
                    hintText: 'Introdu tensiunea',
                    labelText: 'Tensiune',

                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Blood type'),
                  DropdownButton(
                    value: dropdownValueBloodtype,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(

                      height: 2,
                      color: Colors.pinkAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueBloodtype = newValue!;
                        if(dropdownValueBloodtype == "O")
                          bloodType = "0";
                        else if(dropdownValueBloodtype == "A")
                          bloodType = "1";
                        else if(dropdownValueBloodtype == "B")
                          bloodType = "2";
                        else
                          bloodType = "3";
                      });
                    },
                    items: <String>['O', 'A', 'B', 'AB'].map<DropdownMenuItem<String>>((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                  Text('RH'),
                  DropdownButton(
                    value: dropdownValueRh,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.pinkAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValueRh = newValue!;
                        if(dropdownValueRh == "Negative")
                          rh = "0";
                        else
                          rh = "1";
                      });
                    },
                    items: <String>['Negative', 'Positive'].map<DropdownMenuItem<String>>((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                ],

              ),
              TextButton(onPressed: (){
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1960, 1, 1),
                    maxTime: DateTime(2004, 1, 1),
                    theme: DatePickerTheme(
                        headerColor: Colors.pink,
                        backgroundColor: Colors.pink,
                        itemStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                        doneStyle: TextStyle(color: Colors.white, fontSize: 16)
                    ),
                    onConfirm:(date){
                      setState(() {
                        _dateTime = date;

                      });

                    }
                );
              },
                child: const Text("       Pick your birthday", style: TextStyle(color: Colors.pink, fontSize: 17)),
              ),
              Align(
                alignment: Alignment.center,
                child:
                Text(_dateTime == null ? 'Nothing has been picked yet': DateFormat("dd-MM-yyyy").format(_dateTime!),
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 17)
                ),
              ),

              new Container(
                  padding: const EdgeInsets.only(left:170.0, top: 30.0),
                  child: new ElevatedButton(
                    child: const Text("Submit"),
                    onPressed: () {
                        registerUser();
                    },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.pink),
                          )),
                  )
            ],
          ),
        ])
    )
        ));
  }

  Future<void> registerUser() async {
    //get response from ApiClient
    print(passwordController.text);

    Response res = await _apiClient.register(
        emailController.text,
        passwordController.text,
        first_nameController.text,
        last_nameController.text,
        bloodType,
        rh,
        DateFormat("yyyy-MM-dd").format(_dateTime!),
        heightController.text,
        kilogramsController.text,
        bloodPressureController.text
    );
    print(res);
    //String token = "";
    if (res.data['token'] != null) {
      token = res.data['token'];
      // navigate to login
      getUserData();
     // getAppointment();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen(accesstoken: res.data['token'], user: user)));
    } else {
      //if an error occurs, show snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: Invalid dates'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  Future<void> getUserData() async {
    Response userRes;
    userRes = await _apiClient.getUserProfileData(token);
    print(userRes);
    user.id = userRes.data["id"].toString();
    user.firstName = userRes.data["fistName"];
    user.lastName = userRes.data["lastName"];
    user.email = userRes.data["email"];
    user.height = userRes.data["height"].toString();
    user.bloodType = userRes.data["bloodType"];
    user.rh = userRes.data["rh"];
    user.birthdate = userRes.data["birthDate"].toString();
    user.bloodPressure = userRes.data["bloodPressure"].toString();
    user.isPotentialDonor = userRes.data["potentialDonor"].toString();
    user.kilograms = userRes.data["kilograms"].toString();
  }

}
