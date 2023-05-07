import '../../domain/entities/my_phone_auth_credentials.dart';
import '../../domain/entities/verification_id.dart';

abstract class LoginRemoteDataSource {
  Future<VerificationId> getOtp(String countryCode, String phoneNumber);
  Future<MyPhoneAuthCredentials> verifyOtp(String verificationId, String otp);
}
