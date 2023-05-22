import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/models/phone_details.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/repositories/login_screen_repo.dart';

class LoginScreenRepoImpl implements LoginScreenRepo {
  LoginScreenRepoImpl();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // @override
  // Future<String> getOtp(
  //     PhoneDetails phoneDetails,
  //     void Function(PhoneAuthCredential) verificationCompletedHandler,
  //     void Function(String, int?) codeSentHandler,
  //     void Function(FirebaseAuthException) verificationFailedHandler,
  //     void Function(String) codeAutoRetrievalTimeoutHandler) async {
  //   _firebaseAuth.verifyPhoneNumber(
  //     phoneNumber: phoneDetails.countryCode + phoneDetails.phoneNumber,
  //     verificationCompleted: verificationCompletedHandler,
  //     codeSent: codeSentHandler,
  //     verificationFailed: verificationFailedHandler,
  //     codeAutoRetrievalTimeout: codeAutoRetrievalTimeoutHandler,
  //   );
  // }
}
