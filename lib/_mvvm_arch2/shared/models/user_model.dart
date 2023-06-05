import 'package:firebase_auth/firebase_auth.dart';

class CustomUser {
  String phoneNumber;
  String countryCode;
  User? firebaseUser;
  String? email;
  String? firstName;
  String? lastName;

  CustomUser({
    required this.phoneNumber,
    required this.countryCode,
    this.firebaseUser,
    this.email,
    this.firstName,
    this.lastName,
  });

  // factory CustomUser.fromJson(Map<String, dynamic> json) {
  //   return CustomUser(
  //       phoneNumber: json["phoneNumber"], countryCode: json["countryCode"]);
  // }

  Map<String, dynamic> toJson() {
    return {
      "phoneNumber": phoneNumber,
      "countryCode": countryCode,
      "firebaseUser": firebaseUser,
      "email": email,
      "firstName": firstName,
      "lastName": lastName
    };
  }
}
