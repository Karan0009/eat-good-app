// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_screen_2/login_screen/models/phone_details.dart';
import 'package:login_screen_2/shared/models/user_model.dart';

abstract class LoginScreenRepo {
  Future<void> sendOtpWithFirebase(
      PhoneDetails phoneDetails,
      Function verificationFailedCallback,
      Function codeSentCallback,
      Function verificationCompletedCallback);
  Future<User?> signInWithVerificationCode(String smsCode);
  Future<bool> checkExistingUser(String userId);

  Future<bool> saveNewUserDataWithFirestore(CustomUser user);

  Future<Map<String, dynamic>> getUserById(String uid);
  // Future<String> getOtp(
  //     {required PhoneDetails phoneDetails,
  //     required void Function(PhoneAuthCredential) verificationCompletedHandler,
  //     required void Function(String, int?) codeSentHandler,
  //     required void Function(FirebaseAuthException) verificationFailedHandler,
  //     required void Function(String) codeAutoRetrievalTimeoutHandler});
  // Future<Either<Failure, MyPhoneAuthCredentials>> verifyOtp(
  //     String verificationId, String otp);
}
