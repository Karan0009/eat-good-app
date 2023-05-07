import '../../domain/entities/phone_otp_form_data.dart';

class PhoneOtpFormDataModel extends PhoneOtpFormData {
  const PhoneOtpFormDataModel({
    required String countryCode,
    required String phoneNumber,
  }) : super(countryCode: countryCode, phoneNumber: phoneNumber);
}
