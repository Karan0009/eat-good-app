import 'package:equatable/equatable.dart';

class PhoneOtpFormData extends Equatable {
  final String countryCode;
  final String phoneNumber;

  const PhoneOtpFormData(
      {required this.countryCode, required this.phoneNumber});

  @override
  List<Object?> get props => [countryCode, phoneNumber];
}
