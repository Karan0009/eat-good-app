class PhoneDetails {
  String phoneNumber;
  String countryCode;

  PhoneDetails({required this.phoneNumber, required this.countryCode});

  factory PhoneDetails.fromJson(Map<String, dynamic> json) {
    return PhoneDetails(
        phoneNumber: json["phoneNumber"], countryCode: json["countryCode"]);
  }

  Map<String, dynamic> toJson() {
    return {"phoneNumber": phoneNumber, "countryCode": countryCode};
  }
}
