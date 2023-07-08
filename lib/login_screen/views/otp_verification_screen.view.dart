import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen_2/login_screen/view_models/login_screen.viewmodel.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../shared/components/loading_overlay/loading_overlay.dart';
import '../../shared/components/login_screen_footer/login_screen_footer.dart';
import '../../shared/services/app_localizations_service.dart';
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
                            AppLocalizations.of(context)
                                .translate("anOtpWasSentTo"),
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
                                  AppLocalizations.of(context)
                                      .translate("changeNumber"),
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
