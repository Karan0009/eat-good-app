import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_screen_2/shared/repositories/auth_repo/auth_repo.dart';

import '../../../locator.dart';
import '../../../screens/login_screen/models/phone_details.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();
  late String _verificationId;

  AuthRepoImpl();

  @override
  Future<void> sendOtpWithFirebase(
      PhoneDetails phoneDetails,
      Function verificationFailedCallback,
      Function codeSentCallback,
      Function verificationCompletedCallback) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneDetails.getCompletePhoneNumber(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This callback will be triggered when the verification is completed automatically
          // For example, if Firebase can automatically detect the SMS code sent to the phone number
          await _firebaseAuth.signInWithCredential(credential);
          verificationCompletedCallback(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          verificationFailedCallback(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          // This callback will be triggered when the verification code is successfully sent to the phone number
          // Save the verification ID for later use (when user enters the verification code)
          _verificationId = verificationId;
          codeSentCallback(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // This callback will be triggered when the automatic code retrieval times out
          // Handle the timeout accordingly
          _verificationId = verificationId;
          // codeSentCallback(_verificationId);
        },
      );
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<User?> signInWithVerificationCode(String smsCode) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      User? user = (await _firebaseAuth.signInWithCredential(credential)).user;
      return user;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<bool> logoutUser() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (ex) {
      rethrow;
    }
  }
}
