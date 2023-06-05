// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/models/phone_details.dart';

abstract class LoginScreenRepo {
  Future<void> sendOtpWithFirebase(
      PhoneDetails phoneDetails,
      Function verificationFailedCallback,
      Function codeSentCallback,
      Function verificationCompletedCallback);
  Future<User?> signInWithVerificationCode(String smsCode);
  Future<bool> checkExistingUser(String userId);
  // Future<String> getOtp(
  //     {required PhoneDetails phoneDetails,
  //     required void Function(PhoneAuthCredential) verificationCompletedHandler,
  //     required void Function(String, int?) codeSentHandler,
  //     required void Function(FirebaseAuthException) verificationFailedHandler,
  //     required void Function(String) codeAutoRetrievalTimeoutHandler});
  // Future<Either<Failure, MyPhoneAuthCredentials>> verifyOtp(
  //     String verificationId, String otp);
}
