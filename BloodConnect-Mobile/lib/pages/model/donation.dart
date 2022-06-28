import 'dart:core';

class Donation{
  String id;
  String donorId;
  String appointmentId;
  String mana;
  String tip;

  Donation({
    required this.id,
    required this.donorId,
    required this.appointmentId,
    required this.mana,
    required this.tip,
  });
}
