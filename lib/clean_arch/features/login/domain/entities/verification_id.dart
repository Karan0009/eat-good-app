import 'package:equatable/equatable.dart';

class VerificationId extends Equatable {
  final String verificationId;
  final int? resendToken;

  const VerificationId(
      {required this.verificationId, required this.resendToken});

  @override
  List<Object?> get props => [verificationId, resendToken];
}
