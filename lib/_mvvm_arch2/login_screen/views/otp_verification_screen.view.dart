import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/view_models/login_screen.viewmodel.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/services/navigation_service.dart';
import 'package:login_screen_2/screens/home_screen.dart';
import 'package:login_screen_2/screens/new_user_details_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../../shared/components/loading_overlay/loading_overlay.dart';
import '../../shared/components/login_screen_footer/login_screen_footer.dart';
import '../components/resend_otp_button/resend_otp_button.dart';

class LoginOtpScreen extends StatefulWidget {
  final String verificationId;
  final String phone;
  final String countryCode;
  const LoginOtpScreen(this.verificationId, this.countryCode, this.phone,
      {super.key});

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  static const int otpLen = 6;
  int resendOtpTimeInSeconds = 30;
  late Timer interval;
  int remainingResendOtpTimeInSeconds = 0;

  // _LoginOtpScreenState() {
  //   for (int i = 0; i < otpLen; ++i) {
  //     phoneOtpFormKeys.add(GlobalKey<FormState>());
  //   }
  // }
  // final List<GlobalKey<FormState>> phoneOtpFormKeys = [];

  @override
  void initState() {
    super.initState();
    remainingResendOtpTimeInSeconds = resendOtpTimeInSeconds;
    interval = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          remainingResendOtpTimeInSeconds -= 1;
        });
        if (remainingResendOtpTimeInSeconds == 0) {
          interval.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    interval.cancel();
    // TODO: DISPOSE THE PINCONTROLLER
    super.dispose();
  }

  void _navigateToHomeScreen(BuildContext context) {
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const HomeScreen(
    //       initalIndex: 0,
    //     ),
    //   ),
    //   ,
    // );
  }

  void _navigateToEnterNewUserDetailsScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => NewUserDetailsScreen()),
        ((route) => false));
  }

  void restartInterval() {
    setState(() {
      remainingResendOtpTimeInSeconds = resendOtpTimeInSeconds;
      interval = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() {
            remainingResendOtpTimeInSeconds -= 1;
          });
          if (remainingResendOtpTimeInSeconds == 0) {
            interval.cancel();
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context, listen: true);
    // final auth = Provider.of<AuthProvider>(context, listen: true);
    // final args =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // final countryCode = args['countryCode'];
    // final phone = args['phone'];
    final completePhoneNumber = "${widget.countryCode} ${widget.phone}";
    double screenHeight = MediaQuery.of(context).size.height * 0.95;
    return LoadingOverlay(
      isLoading: vm.isLoading,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SizedBox(
                height: screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "An OTP was sent to",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(fontSize: 30),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            completePhoneNumber,
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(fontSize: 30),
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(104, 172, 108, 1)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 0,
                          ),
                          Pinput(
                            enabled: remainingResendOtpTimeInSeconds > 0,
                            autofocus: true,
                            controller: vm.pinController,
                            length: otpLen,
                            androidSmsAutofillMethod:
                                AndroidSmsAutofillMethod.none,
                            onCompleted: (value) {
                              vm.verifyOtpHandler(
                                context: context,
                                verificationId: widget.verificationId,
                                otpValue: value,
                              );
                            },
                            defaultPinTheme: PinTheme(
                              width: 47,
                              height: 57,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromRGBO(242, 244, 247, 1),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(247, 247, 248, 1),
                              ),
                              textStyle: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Color.fromRGBO(102, 112, 133, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ResendOtpButton(
                            remainingResendOtpTimeInSeconds,
                            widget.countryCode,
                            widget.phone,
                            restartInterval,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    {vm.changePhoneNumberHandler(context)},
                                child: Text(
                                  "Change Number",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(104, 172, 108, 1),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
                      child: LoginScreenFooter(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
