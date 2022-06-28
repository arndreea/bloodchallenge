import 'package:blood_connect_mobile/pages/core/ApiClient.dart';
import 'package:blood_connect_mobile/pages/home/home_screen.dart';
import 'package:blood_connect_mobile/pages/home/onboarding_screen.dart';
import 'package:blood_connect_mobile/pages/model/appointment.dart';
import 'package:blood_connect_mobile/utils/validators.dart';
import 'package:blood_connect_mobile/pages/model/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // late ApiClient _apiClient;
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
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'BloodConnect',
                      style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    autovalidateMode :AutovalidateMode.onUserInteraction,
                    validator: (value) => Validator.validateEmail(value ?? ""),
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    autovalidateMode :AutovalidateMode.onUserInteraction,
                    validator: (value) => Validator.validatePassword(value ?? ""),
                    controller: passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'password'),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        print(emailController.text);
                        print(passwordController.text);
                        loginUser();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.pink),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 25)))),
                ),
                Row(
                  children: <Widget>[
                    const Text('Don\'t have an account?'),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.pink),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/RegisterScreen');
                        //register screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              ],
            )));
  }

  Future<void> loginUser() async {
    //get response from ApiClient
    Response res = await _apiClient.login(
      emailController.text,
      passwordController.text,
    );
    //print(res);
   // String token = "";
    if (res.data['token'] != null) {
      print(res.data['token']);
      token = res.data['token'];

      getUserData();

      Navigator.push(
           context, MaterialPageRoute(builder: (context) => OnboardingScreen(accesstoken: res.data['token'], user: user)));

    } else {
      //if an error occurs, show snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: Email or password incorrect'),
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
