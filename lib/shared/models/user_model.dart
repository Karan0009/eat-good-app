import 'dart:convert';

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

  factory CustomUser.fromJson(Map<String, dynamic> json) {
    User? firebaseUserData;
    try {
      firebaseUserData = jsonDecode(json["firebaseUser"]);
    } catch (ex) {
      firebaseUserData = null;
    }
    return CustomUser(
      phoneNumber: json["phoneNumber"],
      countryCode: json["countryCode"],
      firebaseUser: firebaseUserData,
      email: json["email"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "phoneNumber": phoneNumber,
      "countryCode": countryCode,
      "firebaseUser": firebaseUser.toString(),
      "email": email,
      "firstName": firstName,
      "lastName": lastName
    };
  }
}
