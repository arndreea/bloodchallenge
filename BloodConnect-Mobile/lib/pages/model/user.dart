import 'dart:core';

class User{
   String id;
   String firstName;
   String lastName;
   //String? imagePath;
   String email;
   String height;
   String kilograms;
   String bloodPressure;
   String rh;
   String bloodType;
   String birthdate;
   String?isPotentialDonor;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.kilograms,
    required this.bloodPressure,
    required this.rh,
    required this.birthdate,
    required this.isPotentialDonor,
    required this.bloodType,
    required this.height,
});

}
