import 'dart:convert';

import 'package:blood_connect_mobile/pages/model/appointment.dart';
import 'package:dio/dio.dart';
import 'package:blood_connect_mobile/pages/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer' as developer;

//import 'package:loginradius_example/core/constants.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../model/donationdto.dart';

import 'package:flutter_easylogger/console_overlay.dart';
import 'package:flutter_easylogger/console_widget.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_easylogger/log_mode.dart';
import 'package:flutter_easylogger/logger_printer.dart';
import 'package:flutter_easylogger/printer.dart';


class ApiClient {
  final Dio _dio = Dio();

  //static String BASE_URL = 'http://172.21.16.1:27017/';

  Future<Response> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        'http://192.168.100.6:8080/api/auth/login',
        data: {'email': email, 'password': password},
      );
      Logger.i("Login request approved!");
      return response;
    } on DioError catch (e) {
      Logger.e("Login request rejected!");
      return e.response!;
    }
  }

  Future<Response> register(
      String email,
      String password,
      String first_name,
      String last_name,
      String blood_type,
      String rh,
      String birth_date,
      String height,
      String kilograms,
      String bloodPressure) async {
    print(rh);
    try {
      Response response = await _dio.post(
        'http://192.168.100.6:8080/api/auth/sign-up',
        data: {
          'email': email,
          'password': password,
          'fistName': first_name,
          'lastName': last_name,
          'kilograms': kilograms,
          'height': height,
          'bloodType': blood_type,
          'rh': rh,
          'bloodPressure': bloodPressure,
          'birthDate': birth_date,
          'isPotentialDonor': ""
        },
      );
      Logger.i("Registered new user!");
      return response;
    } on DioError catch (e) {
      Logger.e("Couldn't register new user!");
      return e.response!;
    }
  }

  Future<Response> getUserProfileData(String accesstoken) async {
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(accesstoken);
      String id = payload['uid'].toString();
      //print(id);

      Response response = await _dio.get('http://192.168.100.6:8080/user/' + id,
          options: Options(headers: {
            'Authorization': 'Bearer ${accesstoken}',
          }));
      Logger.i("Got user profile data");
      return response;
    } on DioError catch (e) {
      Logger.e(e.message);
      return e.response!;
    }
  }

  Future<Response> saveDonation(String donorId, String appointmentId,
      String tip, String mana, String accesstoken) async {
    try {
      Response response = await _dio.post('http://192.168.100.6:8080/donation',
          data: {
            'donorID': donorId,
            'appointmentID': appointmentId,
            'tip': tip,
            'mana': mana
          },
          options: Options(headers: {
            'Authorization': 'Bearer ${accesstoken}',
          })
          );
      if(response.data != '') {
        try {
          Response response1 = await _dio.put(
              'http://192.168.100.6:8080/appointment/' + appointmentId,
              data: {
                'isActive': false,
              },
              options: Options(headers: {
                'Authorization': 'Bearer ${accesstoken}',
              }));
          Logger.i("Updated appointment isActive status!");
        } on DioError catch (e) {
          Logger.e("Couldn't update appointment isActive status!");
        }
        //after donation, a user is not eligible for another donation
        updateUser(donorId, accesstoken, 'false');
      }
      Logger.i("Saved donation for user!");
      return response;
    } on DioError catch (e) {
      Logger.e("Couldn't save donation for user!");
      return e.response!;
    }
  }

  Future<Response> saveAppointment(String accesstoken, String location,
      String appointmentDate, bool isActive) async {
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(accesstoken);
      String id = payload['uid'].toString();
      print(id);
      Response response = await _dio.post(
          'http://192.168.100.6:8080/appointment/scheduleAppointment',
          data: {
            'location': location,
            'donorID': id,
            'appointmentDate': appointmentDate,
            'isActive': isActive,
          },
          options: Options(headers: {
            'Authorization': 'Bearer ${accesstoken}',
          }));
      Logger.i("Saved appointment for user!");
      return response;
    } on DioError catch (e) {
      Logger.e("Couldn't save appointment for user!");
      return e.response!;
    }
  }

  Future<Appointment> getAppointmentByDonorId(String id, String accesstoken) async {
    Appointment appointment = new Appointment(id: '', donorID: '', location: '', appointmentDate: '', isActive: '');
    try {
      // Map<String, dynamic> payload = Jwt.parseJwt(accesstoken);
      // String id = payload['uid'].toString();
      print(id);

      Response response = await _dio.get('http://192.168.100.6:8080/appointment/donor/' + id,
          options: Options(headers: {
            'Authorization': 'Bearer ${accesstoken}',
          }));
      print(response);

      if(response.data != '') {
        appointment.id = response.data["id"].toString();
        appointment.location = response.data["location"].toString();
        appointment.appointmentDate = response.data["appointmentDate"].toString();
        appointment.donorID = response.data["donorID"].toString();
        appointment.isActive = response.data["isActive"].toString();
      }
      Logger.i("Got user's current appointment!");
      return appointment;
    } on DioError catch (e) {
      Logger.e(e.message);
      return appointment;
    }
  }

  Future<List<DonationDTO>> getDonationsOfUser(String donorId, String accesstoken) async {
    List<DonationDTO> donations = [];
    try {
      //Map<String, dynamic> payload = Jwt.parseJwt(accesstoken);
      //String id  = payload['uid'].toString();
      //print(id);

      //+add isActive variable
      Response response = await _dio.get(
          'http://192.168.100.6:8080/donation/' + donorId,
          options: Options(
              headers: {'Authorization': 'Bearer ${accesstoken}',}
          )
      );

      if(response.data != '') {
        for(int i = response.data.length - 1; i >=0 ; i--){
          print(response.data[i]);
          try {
            Response response1 = await _dio.get(
                'http://192.168.100.6:8080/appointment/' +
                    response.data[i]["appointmentID"].toString(),
                options: Options(
                    headers: {'Authorization': 'Bearer ${accesstoken}',}
                )
            );
            //create a donationDTO
            print(response1.data["appointmentID"].toString()+' raspuns');
            if (response1.data != '') {
              DonationDTO donationDTO = new DonationDTO(id: '', donorId: '', appointmentId: '', location:'', appointmentDate: "", tip: '', mana: '');
              donationDTO.id = response.data[i]["id"].toString();
              donationDTO.donorId = donorId.toString();
              donationDTO.appointmentId =
                  response.data[i]["appointmentID"].toString();
              donationDTO.location = response1.data["location"].toString();
              donationDTO.appointmentDate =
                  response1.data["appointmentDate"].toString();
              donationDTO.tip = response.data[i]["tip"].toString();
              donationDTO.mana = response.data[i]["mana"].toString();
              //put into list
              donations.add(donationDTO);
            }
          }  on DioError catch (e) {
            Logger.e(e.message);
            print(e.message);
          }
        }
      }
      Logger.i("Got all donations for user!");
      return donations;
    } on DioError catch (e) {
      Logger.e(e.message);
      return donations;
    }
  }

  Future<Response> updateUser(String donorId, String accesstoken, String isPotentialDonor) async {
    try {
      print(isPotentialDonor);
      Response response = await _dio.put('http://192.168.100.6:8080/user/' + donorId,
          data: {
            'isPotentialDonor': isPotentialDonor,
          },
          options: Options(headers: {
            'Authorization': 'Bearer ${accesstoken}',
          }));
      Logger.i("Updated donation eligibility status!");
      return response;
    } on DioError catch (e) {
      Logger.e("Couldn't update donation eligibility status!");
      return e.response!;
    }
  }

  //todo api+mobile
  Future<Response> logout(String accessToken) async {
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(accessToken);
      String id = payload['uid'].toString();

      Response response = await _dio.get(
        'https://192.168.100.6:8080/api/auth/access_token/InValidate',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}
