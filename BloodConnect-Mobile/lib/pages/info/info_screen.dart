import 'package:blood_connect_mobile/resources/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _visibleConditions = false;
  bool _visibleExcTemp = false;
  bool _visibleExcDef = false;
  bool _visibleRecBefore = false;
  bool _visibleRecAfter = false;
  bool _visibleBeneficii = false;

  void showConditions() {
    setState(() {
      _visibleConditions = !_visibleConditions;
    });
  }

  void showExcTemp() {
    setState(() {
      _visibleExcTemp = !_visibleExcTemp;
    });
  }

  void showExcDef() {
    setState(() {
      _visibleExcDef = !_visibleExcDef;
    });
  }

  void showRecBefore() {
    setState(() {
      _visibleRecBefore = !_visibleRecBefore;
    });
  }

  void showRecAfter() {
    setState(() {
      _visibleRecAfter = !_visibleRecAfter;
    });
  }

  void showBeneficii() {
    setState(() {
      _visibleBeneficii = !_visibleBeneficii;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: .0,
            backgroundColor: Colors.pink,
            leading: BackButton(
                onPressed: () => Navigator.pop(context),
                color: Colors.white),
            title: Text(Strings.drawer_donation_info),
          ),
          body: SingleChildScrollView(  // <-- wrap this around
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '\n Actul donării este un act voluntar, nimeni nu are\n dreptul să exercite presiuni asupra unei\n persoane să doneze sânge. Persoana în curs de\n evaluare a eligibilității sale ca donator de sânge\n are dreptul, oricând, să se răzgândească, fără\n niciun fel de consecințe.\n',
                  style: TextStyle(fontSize: 18, color: Colors.pink,),

                ),
                ElevatedButton.icon(
                  label: Text('Criterii de eligibilitate pentru donare',style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  icon: Icon(Icons.task_alt_sharp),
                  onPressed: showConditions,
                ),
                Visibility (
                  visible: _visibleConditions,
                  child: Card(
                    child: new ListTile(
                      title: Center(
                        child: new Text('• Cetățenie română sau aparținând Uniunii Europene cu domiciliul în România;\n• Stare generală de sănătate bună;\n• Să aibă la ei actul de identitate;\n• Interval de vârstă: 18-60 ani;\n• Greutate corespunzătoare pentru femei: 55-100 kg, bărbați: 60-110 kg;\n• Puls regulat: 60 -100 bătăi/minut;\n• Tensiune arterială sistolică cuprinsă între 100 şi 180 mmHg'),
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  label: Text('Criterii de excludere temporară',style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  icon: Icon(Icons.warning_amber_rounded),
                  onPressed: showExcTemp,
                ),
                Visibility (
                  visible: _visibleExcTemp,
                  child: Card(
                    child: new ListTile(
                      title: Center(
                        child: new Text('• Să nu aibă tensiune arterială >180/100 mmHg;\n• Anemie;\n•  alergii sezoniere;\n• Tratament medicamentos (însă administrarea de anticoncepționale nu reprezintă un criteriu de excludere);\n• Vaccinare în ultimele 2 săptămâni;\n• Boli infecţioase (gripă , infectii bacteriene), răceli;\n• Afecțiuni dermatologice;\n• Sarcină, alăptare, lăuzie, perioadă menstruală (5 zile înainte/după);\n• Consum de alcool în ultimele 48 de ore;\n• Să nu fii suferit în ultimele 6 luni intervenţii chirurgicale, examinare endoscopică, transfuzii, tatuaje, piercinguri;\n• Intervenții stomatologice (7 zile-tratamente dentare minore, 6-luni lucrări dentare laborioase);\n• Să nu fi avut mai mult de un partener sexual în ultimele 6 luni (risc de avea boli cu transmitere sexuală);\n• Să nu fi consumat grăsimi sau băuturi alcoolice cu cel puţin 48 de ore înaintea donării'),
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  label: Text('Criterii de excludere definitivă',style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  icon: Icon(Icons.clear_sharp),
                  onPressed: showExcDef,
                ),
                Visibility (
                  visible: _visibleExcDef,
                  child: Card(
                    child: new ListTile(
                      title: Center(
                        child: new Text('• Persoanele pensionate medical, indiferent de diagnosticul de pensionare;\n• Miopie forte peste (-) 6 dioptrii;\n• Hiperlipidemie;\n• Astm bronşic;\n• Alergia severă;\n• Boli endocrine;\n• Lupus eritematos diseminat şi alte colagenoze;\n• Diabet zaharat;\n• Afecţiuni cardiovasculare (inclusiv hipertensiunea arterială cronică în tratament, angina pectorală);\n• Boli de piele: psoriazis, vitiligo;\n• Leucemii;\n• Traumatisme craniene cu sechele, boli psihice, epilepsie si alte boli neurologice;\n• Ulcer;\n• Cancer;\n• Ciroză hepatică;\n• Etilism cronic;\n• Pancreatită;\n• TBC;\n• Sifilis;\n• Bruceloză;\n• Malarie'),
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  label: Text('Recomandări înainte de donare',style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: Icon(Icons.navigate_before_sharp),
                  onPressed: showRecBefore,
                ),
                Visibility (
                  visible: _visibleRecBefore,
                  child: Card(
                    child: new ListTile(
                      title: Center(
                        child: new Text('• Să fii odihnit (nu după tură de noapte la serviciu sau in fata calculatorului);\n• Să nu fi mâncat grăsimi în ultimele 24 ore;\n• Nu fuma înainte şi după donare cu o oră;\n• Poți consuma o cană cu ceai sau cafea, un mic dejun puţin consistent, legume și fructe'),
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  label: Text('Recomandări după donare',style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  icon: Icon(Icons.navigate_next_sharp),
                  onPressed: showRecAfter,
                ),
                Visibility (
                  visible: _visibleRecAfter,
                  child: Card(
                    child: new ListTile(
                      title: Center(
                        child: new Text('• E recomandat să crești consumul de lichide in primele 24 de ore;\n• Să nu faci efort fizic intens'),
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  label: Text('Beneficii pentru sănătate',style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  icon: Icon(Icons.local_hospital_outlined),
                  onPressed: showBeneficii,
                ),
                Visibility (
                  visible: _visibleBeneficii,
                  child: Card(
                    child: new ListTile(
                      title: Center(
                        child: new Text('• Creșterea antioxidanților plasmatici;                                 \n• Scăderea lipidemiei;\n• Reducerea hipertensiunii arteriale;\n• Calitate superioară a sănătății'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        // body: AppointmentForm(),
      ),
    );
  }
}