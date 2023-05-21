import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/models/phone_details.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/view_models/loading.viewmodel.dart';

import '../../shared/utils/utils.dart';
import '../repositories/login_screen_repo.dart';

class LoginViewModel extends LoadingViewModel {
  LoginViewModel({required this.loginRepo}) : super();

  final LoginScreenRepo loginRepo;

  PhoneDetails phoneDetails = PhoneDetails(phoneNumber: "", countryCode: "+91");
  List<String> phoneCodes = ["+91", "+10"];

  setPhoneDetails(String? countryCode, String? phoneNumber) {
    phoneDetails.countryCode = countryCode ?? phoneDetails.countryCode;
    phoneDetails.phoneNumber = phoneNumber ?? phoneDetails.phoneNumber;
  }

  getOtpHandler(BuildContext context, Function restartOtpTimerHandler) {
    try {
      isLoading = true;
      notifyListeners();
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

  getPhoneCodes() {
    return phoneCodes;
  }
}
