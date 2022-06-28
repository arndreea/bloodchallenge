import 'dart:core';

class Appointment{
  String id;
  String donorID;
  String location;
  String appointmentDate;
  String isActive;

  Appointment({
    required this.id,
    required this.donorID,
    required this.location,
    required this.appointmentDate,
    required this.isActive,
  });

}