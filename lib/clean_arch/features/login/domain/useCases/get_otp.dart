import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';

import '../entities/verification_id.dart';
import '../repositories/i_login_repository.dart';

class GetOtp implements UseCase<VerificationId, GetOtpParams> {
  final ILoginRepository repository;

  GetOtp(this.repository);

  @override
  Future<Either<Failure, VerificationId>> call(GetOtpParams params) async {
    return await repository.getOtp(params.countryCode, params.phoneNumber);
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

class GetOtpParams {
  final String countryCode;
  final String phoneNumber;

  GetOtpParams({required this.countryCode, required this.phoneNumber});
}
