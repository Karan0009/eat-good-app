import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/my_phone_auth_credentials.dart';
import '../entities/verification_id.dart';

abstract class ILoginRepository {
  Future<Either<Failure, VerificationId>> getOtp(
      String countryCode, String phoneNumber);
  Future<Either<Failure, MyPhoneAuthCredentials>> verifyOtp(
      String verificationId, String otp);
}
