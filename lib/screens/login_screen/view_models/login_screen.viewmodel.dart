import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_screen_2/locator.dart';
import 'package:login_screen_2/screens/login_screen/models/phone_details.dart';
import 'package:login_screen_2/shared/constants/app_constants.dart';
import 'package:login_screen_2/shared/models/image_details.dart';
import 'package:login_screen_2/shared/models/user_model.dart';
import 'package:login_screen_2/shared/repositories/auth_repo/auth_repo.dart';
import 'package:login_screen_2/shared/repositories/user_repo/user_repo.dart';
import 'package:login_screen_2/shared/routes/routes.dart';
import 'package:login_screen_2/shared/view_models/loading.viewmodel.dart';

import '../../home_screen/models/home_page_view_arguments.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../shared/services/navigation_service.dart';
import '../../../shared/utils/utils.dart';
import '../views/otp_verification_screen.view.dart';

class LoginViewModel extends LoadingViewModel {
  LoginViewModel({
    required this.authRepo,
    required this.userRepo,
  }) : super();

  final AuthRepo authRepo;
  final UserRepository userRepo;
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
        await authRepo.sendOtpWithFirebase(
          otherPhoneDetails,
          verificationFailedHandler(context),
          codeSentHandler(context),
          verificationCompletedHandler(context),
        );
      } else {
        await authRepo.sendOtpWithFirebase(
          phoneDetails,
          verificationFailedHandler(context),
          codeSentHandler(context),
          verificationCompletedHandler(context),
        );
      }
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      Utils.showSnackBar(context, e.message.toString());
    } catch (ex) {
      isLoading = false;
      Utils.showSnackBar(context, "Some error occured");
    }
  }

  Function verificationFailedHandler(BuildContext context) {
    return (FirebaseAuthException exception) {
      isLoading = false;
      Utils.showSnackBar(context, exception.message.toString());
    };
  }

  Function codeSentHandler(BuildContext context) {
    return (String verificationId) {
      isLoading = false;
      resetOtpValue();
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
    try {
      navigateToHome();
    } catch (ex) {
      Utils.showSnackBar(context, ex.toString());
    }
  }

  void navigateToHome() {
    _navService.nav.pushNamedAndRemoveUntil(
      NamedRoute.homeScreen,
      (route) => false,
      arguments: HomePageViewArguments(
        initalIndex: 0,
      ),
    );
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
  //     } else {
  //       _navigateToEnterNewUserDetailsScreen(
  //           context);
  //     }
  //   }).catchError((e) {
  //     showSnackBar(context, e.toString());
  //   });
  // },

  void resetOtpValue() {
    pinController.text = "";
  }

  void verifyOtpHandler(
      {required BuildContext context,
      required String verificationId,
      required String otpValue}) async {
    try {
      isLoading = true;
      final user = await authRepo.signInWithVerificationCode(otpValue);
      if (user == null) {
        throw Exception("no user found");
      }
      CustomUser loggedInUser = CustomUser(
        phoneNumber: user.phoneNumber ?? "",
        countryCode: "",
        email: user.email,
        firebaseUser: user.uid,
        profilePhoto: ImageDetails.empty(),
      );
      _userProvider.setLoggedInUser(loggedInUser);
      bool isExistingUser = await userRepo.checkExistingUser(user.uid);
      if (isExistingUser) {
        final userData = await userRepo.getUserById(user.uid);
        _userProvider.setLoggedInUser(CustomUser.fromJson(userData));
        final isUserSavedLocally =
            await _userProvider.saveLoggedInUserLocally();
        if (!isUserSavedLocally) {
          throw Exception("Error in saving user");
        } else {
          _navService.nav.pushNamedAndRemoveUntil(
            NamedRoute.homeScreen,
            (route) => false,
            arguments: HomePageViewArguments.fromJson({"initalIndex": 1}),
          );
        }
      } else {
        _navService.nav.pushNamedAndRemoveUntil(
          NamedRoute.newUserDetailsScreen,
          (route) => false,
          arguments: {},
        );
      }
      isLoading = false;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      Utils.showSnackBar(context, e.message.toString());
    } catch (ex) {
      isLoading = false;
      Utils.showSnackBar(context, "Some error occured");
    }
  }

  void changePhoneNumberHandler(BuildContext context) {
    _navService.nav.pushNamedAndRemoveUntil(
      NamedRoute.loginScreen,
      (route) => false,
    );
  }

  void showChangePhoneNumberAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Do you want to change your phone number?"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _navService.nav.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              child: const Text('Change'),
              onPressed: () {
                changePhoneNumberHandler(context);
              },
            ),
          ],
        );
      },
    );
  }

  void newUserDetailsNextClickHandler(BuildContext context, String firstName,
      {String? lastName}) async {
    try {
      isLoading = true;

      _userProvider.setFirstName(firstName);
      if (lastName != null) {
        _userProvider.setLastName(lastName);
      }
      _userProvider.setProfilePhoto(AppConstants.defaultProfilePhoto);

      final isUserSavedLocally = await _userProvider.saveLoggedInUserLocally();
      if (!isUserSavedLocally) {
        throw Exception("Error in saving user data");
      }
      var user = _userProvider.user;
      if (user != null) {
        final isUserSaved = await userRepo.saveNewUserDataWithFirestore(user);
        if (isUserSaved) {
          navigateToHome();
        } else {
          throw Exception("Error in creating your profile");
        }
      }
      isLoading = false;
    } catch (ex) {
      isLoading = false;
      Utils.showSnackBar(context, "Some error occured");
    }
  }
}
