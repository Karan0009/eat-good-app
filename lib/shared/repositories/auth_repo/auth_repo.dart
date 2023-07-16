import 'package:firebase_auth/firebase_auth.dart';

import '../../../screens/login_screen/models/phone_details.dart';

abstract class AuthRepo {
  Future<void> sendOtpWithFirebase(
      PhoneDetails phoneDetails,
      Function verificationFailedCallback,
      Function codeSentCallback,
      Function verificationCompletedCallback);
  Future<User?> signInWithVerificationCode(String smsCode);

  Future<bool> logoutUser();
}
