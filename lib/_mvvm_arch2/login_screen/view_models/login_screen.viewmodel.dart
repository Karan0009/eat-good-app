import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/models/phone_details.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/view_models/loading.viewmodel.dart';

import '../../shared/utils/utils.dart';
import '../repositories/login_screen_repo.dart';

class LoginViewModel extends LoadingViewModel {
  LoginViewModel({required this.loginRepo}) : super();

  final LoginScreenRepo loginRepo;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  PhoneDetails phoneDetails = PhoneDetails(phoneNumber: "", countryCode: "+91");
  List<String> phoneCodes = ["+91", "+10"];

  setPhoneDetails(String? countryCode, String? phoneNumber) {
    phoneDetails.countryCode = countryCode ?? phoneDetails.countryCode;
    phoneDetails.phoneNumber = phoneNumber ?? phoneDetails.phoneNumber;
  }

  void getOtpHandler(
      BuildContext context, Function restartOtpTimerHandler) async {
    try {
      isLoading = true;
      notifyListeners();

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "${phoneDetails.countryCode}${phoneDetails.phoneNumber}",
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          isLoading = false;
          notifyListeners();
          // pinController.text = phoneAuthCredential.smsCode.toString();
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          isLoading = false;
          notifyListeners();
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          isLoading = false;
          notifyListeners();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         LoginOtpScreen(verificationId, countryCode, phoneNumber),
          //   ),
          // );
          restartOtpTimerHandler();
        },
        codeAutoRetrievalTimeout: (verificationId) {
          isLoading = false;
          notifyListeners();
        },
      );
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      Utils.showSnackBar(context, e.message.toString());
    } catch (ex) {
      isLoading = false;
      notifyListeners();
      Utils.showSnackBar(context, "Some error occured");
    }
  }

  void verificationCompletedHandler(PhoneAuthCredential creds) async {
    isLoading = false;
    notifyListeners();
    // pinController.text = phoneAuthCredential.smsCode.toString();
    await _firebaseAuth.signInWithCredential(creds);
  }

  void verificationFailedHandler(FirebaseAuthException exception) {}

  void codeSentHandler(String verificationId, int? forceResendingToken) {}

  signupWithGoogleHandler(BuildContext context) {
    try {} catch (ex) {
      Utils.showSnackBar(context, ex.toString());
    }
  }

  skipSigninHandler(BuildContext context) {
    try {} catch (ex) {
      Utils.showSnackBar(context, ex.toString());
    }
  }

  openTermsAndConditionsLinkHandler(BuildContext context) {
    try {} catch (ex) {
      Utils.showSnackBar(context, ex.toString());
    }
  }

  List<String> getPhoneCodes() {
    return phoneCodes;
  }
}
