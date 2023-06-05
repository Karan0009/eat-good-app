import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/locator.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/models/phone_details.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/models/user_model.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/routes/routes.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/view_models/loading.viewmodel.dart';

import '../../shared/providers/user_provider.dart';
import '../../shared/services/navigation_service.dart';
import '../../shared/utils/utils.dart';
import '../repositories/login_screen_repo.dart';
import '../views/otp_verification_screen.view.dart';

class LoginViewModel extends LoadingViewModel {
  LoginViewModel({required this.loginRepo}) : super();

  final LoginScreenRepo loginRepo;
  // final UserProvider userProvider;

  final TextEditingController _pinController = TextEditingController();
  TextEditingController get pinController => _pinController;
  final UserProvider _userProvider = locator<UserProvider>();
  final NavigationService _navService = locator<NavigationService>();

  PhoneDetails phoneDetails = PhoneDetails(phoneNumber: "", countryCode: "+91");
  List<String> phoneCodes = ["+91", "+10"];

  setPhoneDetails(String? countryCode, String? phoneNumber) {
    phoneDetails.countryCode = countryCode ?? phoneDetails.countryCode;
    phoneDetails.phoneNumber = phoneNumber ?? phoneDetails.phoneNumber;
  }

  void getOtpHandler(BuildContext context, Function restartOtpTimerHandler,
      {PhoneDetails? otherPhoneDetails}) async {
    try {
      isLoading = true;
      if (otherPhoneDetails != null) {
        await loginRepo.sendOtpWithFirebase(
            otherPhoneDetails,
            verificationFailedHandler(context),
            codeSentHandler(context),
            verificationCompletedHandler(context));
      } else {
        await loginRepo.sendOtpWithFirebase(
            phoneDetails,
            verificationFailedHandler(context),
            codeSentHandler(context),
            verificationCompletedHandler(context));
      }
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

  Function verificationFailedHandler(BuildContext context) {
    return (FirebaseAuthException exception) {
      isLoading = false;
      notifyListeners();
      Utils.showSnackBar(context, exception.message.toString());
    };
  }

  Function codeSentHandler(BuildContext context) {
    return (String verificationId) {
      isLoading = false;

      _navService.nav.pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginOtpScreen(
            verificationId,
            phoneDetails.countryCode,
            phoneDetails.phoneNumber,
          ),
        ),
      );
    };
  }

  Function verificationCompletedHandler(BuildContext context) {
    return (PhoneAuthCredential creds) {
      isLoading = false;
      pinController.text = creds.smsCode.toString();
    };
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

  List<String> getPhoneCodes() {
    return phoneCodes;
  }

  // onSuccess: () {
  //   auth
  //       .checkExistingUser()
  //       .then((doesExist) async {
  //     if (doesExist) {
  //       _navigateToHomeScreen(context);
  //       // TODO: NAVIGATE TO PROFILE PAGE
  //     } else {
  //       _navigateToEnterNewUserDetailsScreen(
  //           context);
  //     }
  //   }).catchError((e) {
  //     showSnackBar(context, e.toString());
  //   });
  // },

  void verifyOtpHandler(
      {required BuildContext context,
      required String verificationId,
      required String otpValue}) async {
    try {
      isLoading = true;
      final user = await loginRepo.signInWithVerificationCode(otpValue);
      if (user == null) {
        throw Exception("no user found");
      }
      CustomUser loggedInUser = CustomUser(
          phoneNumber: user.phoneNumber ?? "",
          countryCode: "",
          firebaseUser: user);
      _userProvider.setLoggedInUser(loggedInUser);
      bool isExistingUser = await loginRepo.checkExistingUser(user.uid);
      if (isExistingUser) {
        _navService.nav.pushNamedAndRemoveUntil(
            NamedRoute.homeScreen, (route) => false,
            arguments: {"initalIndex": 0});
      } else {
        // TODO: navigate to add details page
      }
      isLoading = false;
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

  void changePhoneNumberHandler(BuildContext context) {
    _navService.nav
        .pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
  }
}
