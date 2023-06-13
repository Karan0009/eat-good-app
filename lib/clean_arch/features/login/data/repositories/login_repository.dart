import 'package:login_screen_2/clean_arch/features/login/domain/entities/verification_id.dart';
import 'package:login_screen_2/clean_arch/features/login/domain/entities/my_phone_auth_credentials.dart';
import 'package:login_screen_2/clean_arch/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:login_screen_2/clean_arch/features/login/domain/repositories/i_login_repository.dart';

class LoginRepository implements ILoginRepository {
  @override
  Future<Either<Failure, VerificationId>> getOtp(
      String countryCode, String phoneNumber) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MyPhoneAuthCredentials>> verifyOtp(
      String verificationId, String otp) {
    throw UnimplementedError();
  }
}
