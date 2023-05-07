import 'package:dartz/dartz.dart';
import 'package:login_screen_2/clean_arch/features/login/domain/entities/my_phone_auth_credentials.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/i_login_repository.dart';

class VerifyOtp implements UseCase<MyPhoneAuthCredentials, VerifyOtpParams> {
  final ILoginRepository repository;

  VerifyOtp(this.repository);

  @override
  Future<Either<Failure, MyPhoneAuthCredentials>> call(
      VerifyOtpParams params) async {
    return await repository.verifyOtp(params.verificationId, params.otp);
  }
  /**
   * In dart there is a concept of callable classes
   * 
   * In our execute method can be replaced with call method
   * and we can just write 
   * loginRepository(repo) 
   * instead of loginRepository.execute(repo);
   */
}

class VerifyOtpParams {
  final String verificationId;
  final String otp;

  VerifyOtpParams({required this.verificationId, required this.otp});
}
