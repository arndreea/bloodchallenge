import 'package:dio/src/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../resources/texts.dart';
import '../core/ApiClient.dart';
import '../home/home_screen.dart';
import '../model/user.dart';

class FormScreen extends StatefulWidget {
  final String accesstoken;
  final User user;

  const FormScreen ({Key? key, required this.user, required this.accesstoken}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _valueSelected1 = false;
  bool _valueSelected2 = false;
  bool _valueSelected3 = false;
  bool _valueSelected4 = false;
  bool _valueSelected5 = false;
  bool _valueSelected6 = false;
  bool _valueSelected7 = false;
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  bool _isSelected3 = false;
  bool _isSelected4 = false;
  bool _isSelected5 = false;
  bool _isSelected6 = false;
  bool _isSelected7 = false;
  bool _isButtonEnabled = false;

  final ApiClient _apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.pink,
        elevation: .0,
        leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.white),
        title: new Text(Strings.drawer_donation_eligibility),
      ),
      body:Container(
        child: ListView(
          //controller: myController,
          children: <Widget>[
            Text(
              "\n      Va rog răspundeți la următoarele întrebări \n      pentru a determina dacă puteți dona în \n      momentul actual: \n",
              style: TextStyle(fontSize: 18, color: Colors.pink,),
            ),
            LabeledSwitch(
              label: 'De la ultima donare, sau în ultimele 12 luni, ați făcut o intervenție chirurgicală, tatuaje, găuri în urechi sau acupunctură?\n',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _valueSelected1,
              onChanged: (bool newValue) {
                _valueSelected1 = newValue;
                _isSelected1 = true;
                if(_isSelected1 && _isSelected2 && _isSelected3 && _isSelected4 && _isSelected5 && _isSelected6 && _isSelected7)
                  _isButtonEnabled = true;
              },
            ),
            LabeledSwitch(
              label: 'În ultima vreme, ați avut: o pirdere în greutate neașteptată, febra inexplicabilă, tratament somatologic, vaccinari sau deficit de vitamine?\n',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _valueSelected2,
              onChanged: (bool newValue) {
                _valueSelected2 = newValue;
                _isSelected2 = true;
                if(_isSelected1 && _isSelected2 && _isSelected3 && _isSelected4 && _isSelected5 && _isSelected6 && _isSelected7)
                  _isButtonEnabled = true;
              },
            ),
            LabeledSwitch(
              label: 'Sunteți sub tratament pentru diferite afecțiuni: hipertensiune, boli de inima, boli renale, boli psihice, boli hepatice, boli endocrine ?\n',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _valueSelected3,
              onChanged: (bool newValue) {
                _valueSelected3 = newValue;
                _isSelected3 = true;
                if(_isSelected1 && _isSelected2 && _isSelected3 && _isSelected4 && _isSelected5 && _isSelected6 && _isSelected7)
                  _isButtonEnabled = true;
              },
            ),
            LabeledSwitch(
              label: 'Ați fost expus la hepatită?\n',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _valueSelected4,
              onChanged: (bool newValue) {
                _valueSelected4 = newValue;
                _isSelected4 = true;
                if(_isSelected1 && _isSelected2 && _isSelected3 && _isSelected4 && _isSelected5 && _isSelected6 && _isSelected7)
                  _isButtonEnabled = true;
              },
            ),
            LabeledSwitch(
              label: 'Au trecut mai puțin de 80 de zile de la ultima donare?\n',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _valueSelected5,
              onChanged: (bool newValue) {
                _valueSelected5 = newValue;
                _isSelected5 = true;
                if(_isSelected1 && _isSelected2 && _isSelected3 && _isSelected4 && _isSelected5 && _isSelected6 && _isSelected7)
                  _isButtonEnabled = true;
              },
            ),
            LabeledSwitch(
              label: 'Prezentați afecțiuni de genul: boli de piele, sechele pulmonare, ulcer, tendința de sângerare anormală?\n',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _valueSelected6,
              onChanged: (bool newValue) {
                _valueSelected6 = newValue;
                _isSelected6 = true;
                if(_isSelected1 && _isSelected2 && _isSelected3 && _isSelected4 && _isSelected5 && _isSelected6 && _isSelected7)
                  _isButtonEnabled = true;
              },
            ),
            LabeledSwitch(
              label: 'Sunteți însărcinată sau în perioada de menstruație?\n',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _valueSelected7,
              onChanged: (bool newValue) {
                _valueSelected7 = newValue;
                _isSelected7 = true;
                if(_isSelected1 && _isSelected2 && _isSelected3 && _isSelected4 && _isSelected5 && _isSelected6 && _isSelected7)
                  _isButtonEnabled = true;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print(_valueSelected1.toString()+" "+_valueSelected2.toString()+" "+_valueSelected3.toString()+" "+_valueSelected4.toString()+" "+_valueSelected5.toString()+" "+_valueSelected6.toString()+" "+_valueSelected7.toString());
          if(_isButtonEnabled) {
            if(_valueSelected1 && _valueSelected2 && _valueSelected3  && _valueSelected4 && _valueSelected5 && _valueSelected6 && _valueSelected7){
              {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Felicitări!', style: TextStyle(color: Colors.pink)),
                      content: Text('Sunteți apt pentru a dona!', style: TextStyle(color: Colors.black)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            updateUser("true");
                            widget.user.isPotentialDonor = 'true';
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomeScreen(accesstoken: widget.accesstoken, user: widget.user,)));
                          },
                          child: Text('Înapoi la pagina principală', style: TextStyle(color: Colors.pink)),
                        ),
                      ],
                    );
                  },
                );
              }
            } else{
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Ne pare rău!', style: TextStyle(color: Colors.pink)),
                    content: Text('Din păcate nu sunteți apt pentru donare!', style: TextStyle(color: Colors.black)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          updateUser("false");
                          widget.user.isPotentialDonor = 'false';
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => HomeScreen(accesstoken: widget.accesstoken, user: widget.user,)));
                        },
                        child: Text('Înapoi la pagina principală', style: TextStyle(color: Colors.pink)),
                      ),
                    ],
                  );
                },
              );
            }
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Formular incomplet!', style: TextStyle(color: Colors.pink)),
                  content: Text('Nu ați selectat toate câmpurile necesare!', style: TextStyle(color: Colors.black)),
                  actions: [
                    TextButton(
                      //textColor: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Înapoi la formularul de donare', style: TextStyle(color: Colors.pink)),
                    ),
                  ],
                );
              },
            );
          }
        },
        label: const Text('Trimite formularul'),
        //icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> updateUser(String value) async{
    Response res = await _apiClient.updateUser(
        widget.user.id,
        widget.accesstoken,
        value
    );
  }
}

class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    Key? key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            ToggleSwitch(
              minWidth: 45.0,
              minHeight: 30.0,
              fontSize: 16.0,
              initialLabelIndex: 0,
              activeBgColors: [[Colors.pink], [Colors.green]],
              //activeBgColor: [Color.fromRGBO(255, 33, 86, 1.0)],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              labels: ['Da','Nu'],
              animate: true,
              curve: Curves.bounceInOut,
              onToggle: (index) {
                print('switched to: $index');
                if(index==1)
                  onChanged(true);
                if(index==0)
                  onChanged(false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
