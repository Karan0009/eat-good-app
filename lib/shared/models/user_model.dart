class CustomUser {
  String phoneNumber;
  String countryCode;
  String? firebaseUser;
  String? email;
  String? firstName;
  String? lastName;
  String? profilePhoto;

  CustomUser({
    required this.phoneNumber,
    required this.countryCode,
    this.firebaseUser,
    this.email,
    this.firstName,
    this.lastName,
    this.profilePhoto,
  });

  factory CustomUser.fromJson(Map<String, dynamic> json) {
    return CustomUser(
        phoneNumber: json["phoneNumber"],
        countryCode: json["countryCode"],
        firebaseUser: json["firebaseUser"],
        email: json["email"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        profilePhoto: json["profilePhoto"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "phoneNumber": phoneNumber,
      "countryCode": countryCode,
      "firebaseUser": firebaseUser,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "profilePhoto": profilePhoto
    };
  }

  String getFullName() {
    return "${firstName ?? ''} ${lastName ?? ''}";
  }

  static List<String> parseFullName(String fullName) {
    List<String> parsedFullName = [];
    String lastName = "";
    List<String> splittedFullName = fullName.split(' ');
    if (splittedFullName.length > 1) {
      lastName = splittedFullName.sublist(1).join(' ');
    }
    parsedFullName.add(splittedFullName[0]);
    parsedFullName.add(lastName);
    return parsedFullName;
  }
}
