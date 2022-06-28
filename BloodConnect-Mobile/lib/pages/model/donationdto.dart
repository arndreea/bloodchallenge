import 'package:blood_connect_mobile/pages/model/donation.dart';

class DonationDTO{
  String id;
  String donorId;
  String appointmentId;
  String location;
  String appointmentDate;
  String mana;
  String tip;

  DonationDTO({
    required this.id,
    required this.donorId,
    required this.appointmentId,
    required this.location,
    required this.appointmentDate,
    required this.mana,
    required this.tip,
  });
}