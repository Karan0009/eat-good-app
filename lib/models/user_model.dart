class UserModel {
  String firstName;
  String lastName;
  String phoneNumber;
  String createdAt;
  String uid;

  UserModel(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.createdAt,
      required this.uid});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        firstName: map['firstName'] ?? '',
        lastName: map['lastName'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        createdAt: map['createdAt'] ?? '',
        uid: map['uid']);
  }

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "uid": uid
    };
  }
}
