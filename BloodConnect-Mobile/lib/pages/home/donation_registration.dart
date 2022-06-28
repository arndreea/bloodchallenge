import 'package:blood_connect_mobile/pages/home/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/ApiClient.dart';

class DonationRegistrationScreen extends StatefulWidget {

  final String accesstoken;
  final String donorId;
  final String appointmentId;
  const DonationRegistrationScreen({Key? key, required this.accesstoken, required this.donorId, required this.appointmentId}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _DonationRegistrationState();
}

enum tipDonation { sange, afereza }
enum tipMana {stanga, dreapta}

class _DonationRegistrationState extends State<DonationRegistrationScreen> {

  final ApiClient _apiClient = ApiClient();
  tipDonation? donare = tipDonation.sange;
  tipMana? mana = tipMana.stanga;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: .0,
        leading: BackButton(
            onPressed: () => Navigator.pop(context),
        color: Colors.white),
        title: Text("Inregistrare donare"),
      ),
        resizeToAvoidBottomInset:true,
      body: new Padding(padding: const EdgeInsets.all(12.0),
    child:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(left: 16),
                  child:
                 Text("Ce tip de donare ai facut?    ", style: TextStyle(
                   fontSize: 21,
            ),),),
                RadioListTile<tipDonation>(
                  activeColor: Colors.pinkAccent,
                  title: const Text('Sange'),
                  value: tipDonation.sange,
                  groupValue: donare,
                  onChanged: (tipDonation? value) {
                    setState(() {
                      donare = value;

                    });
                  },
                ),
                RadioListTile<tipDonation>(
                  activeColor: Colors.pinkAccent,
                  title: const Text('Afereza'),
                  value: tipDonation.afereza,
                  groupValue: donare,
                  onChanged: (tipDonation? value) {
                    setState(() {
                      donare = value;

                    });
                  },
                ),
              Padding(padding: const EdgeInsets.only(bottom:30.0)),
          Padding(padding: const EdgeInsets.only(left: 16),
              child:
              Text("Din ce mana ati donat?  ", style: TextStyle(
                fontSize: 21
              ),),),
            RadioListTile<tipMana>(
              activeColor: Colors.pinkAccent,
              title: const Text('Stanga'),
              value: tipMana.stanga,
              groupValue: mana,
              onChanged: (tipMana? value) {
                setState(() {
                 mana = value;

                });
              },
            ),
            RadioListTile<tipMana>(
              activeColor: Colors.pinkAccent,
              title: const Text('Dreapta'),
              value: tipMana.dreapta,
              groupValue: mana,
              onChanged: (tipMana? value) {
                setState(() {
                  mana = value;

                });
              },
            ),
                  Padding(padding: const EdgeInsets.only(left: 110, top:45),
                      child: ElevatedButton(
                      child: const Text('Inregistrare'),
                      onPressed: () {
                              saveDonation();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(255, 33, 86, 1.0)),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 20)))),


                  )
                ]
            )
                  )
    )

      )
    );




  }

  Future<void> saveDonation() async {
    //get response from ApiClient

    Response res = await _apiClient.saveDonation(
      widget.donorId.toString(),
      widget.appointmentId.toString(),
      donare.toString().split('.').last,
      mana.toString().split('.').last,
      widget.accesstoken.toString()
    );
    print(res);
    if (res.data['id'] != null) {
      // navigate to login
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomeScreen(accesstoken: widget.accesstoken)));
      Navigator.pop(context);
    } else {
      //if an error occurs, show snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: Invalid dates'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}