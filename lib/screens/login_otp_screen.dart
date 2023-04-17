import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen_2/screens/home_screen.dart';
import 'package:login_screen_2/screens/new_user_details_screen.dart';
import 'package:login_screen_2/utils/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../components/login_screen_footer.dart';
import '../providers/auth_provider.dart';

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
  _LoginOtpScreenState() {
    for (int i = 0; i < otpLen; ++i) {
      phoneOtpFormKeys.add(GlobalKey<FormState>());
    }
  }
  final List<GlobalKey<FormState>> phoneOtpFormKeys = [];

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
    super.dispose();
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        ((route) => false));
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
    final auth = Provider.of<AuthProvider>(context, listen: true);
    // final args =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // final countryCode = args['countryCode'];
    // final phone = args['phone'];
    final completePhoneNumber = "${widget.countryCode} ${widget.phone}";
    double screenHeight = MediaQuery.of(context).size.height * 0.95;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              height: screenHeight,
              // decoration: const BoxDecoration(color: Colors.yellow),
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
                          length: 6,
                          onCompleted: (value) {
                            auth.verifyOtp(
                              context: context,
                              verificationId: widget.verificationId,
                              userOtp: value,
                              onSuccess: () {
                                auth
                                    .checkExistingUser()
                                    .then((doesExist) async {
                                  if (doesExist) {
                                    _navigateToHomeScreen(context);
                                    // TODO: NAVIGATE TO PROFILE PAGE
                                  } else {
                                    _navigateToEnterNewUserDetailsScreen(
                                        context);
                                  }
                                }).catchError((e) {
                                  showSnackBar(context, e.toString());
                                });
                              },
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
                        // FocusNodeExample(),
                        // _PhoneOtpForm(
                        //   formKeys: phoneOtpFormKeys,
                        //   otpLen: otpLen,
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        ResendOtpButton(remainingResendOtpTimeInSeconds,
                            widget.countryCode, widget.phone, restartInterval),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => {_navigateToLoginScreen(context)},
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
    );
  }
}

class _PhoneOtpForm extends StatefulWidget {
  _PhoneOtpForm({required this.formKeys, required this.otpLen}) {
    for (int i = 0; i < otpLen; ++i) {
      focusNodes.add(FocusNode());
    }
  }
  final List<GlobalKey<FormState>> formKeys;
  final int otpLen;
  final List<FocusNode> focusNodes = [];
  @override
  State<_PhoneOtpForm> createState() => _PhoneOtpFormState();
}

class _PhoneOtpFormState extends State<_PhoneOtpForm> {
  _PhoneOtpFormState() {
    for (int i = 0; i < 6; ++i) {
      otpVal.add("");
    }
  }
  List<String> otpVal = [];
  bool otpFetchedFromSms = false;
  FocusNode? currentFocusNode;

  @override
  void initState() {
    // super.initState();
    // currentFocusNode = widget.focusNodes[0];
    // try {
    //   currentFocusNode?.requestFocus();
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text(
              'Reading OTP',
              style: TextStyle(
                color: Color.fromRGBO(102, 112, 133, 1),
              ),
            ),
            Container(
              height: 10,
              width: 10,
              margin: const EdgeInsets.only(left: 10),
              child: const CircularProgressIndicator(strokeWidth: 1),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...widget.formKeys
                .asMap()
                .entries
                .map((item) => Flexible(
                      flex: 1,
                      child: Container(
                        width: 47,
                        height: 57,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(242, 244, 247, 1),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(247, 247, 248, 1),
                        ),
                        child: TextFormField(
                          key: item.value,
                          focusNode: widget.focusNodes[item.key],
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Color.fromRGBO(102, 112, 133, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          autofocus: false,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "",
                            counterText: "",
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(102, 112, 133, 0.5),
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                          validator: (value) {
                            return null;
                          },
                          onTap: () {
                            print("setting focus to:${item.key}");
                            widget.focusNodes[item.key].requestFocus();
                          },
                          onChanged: (value) {
                            print("value:$value, ${item.key}");
                            if (value == '') {
                              if (item.key > 0) {
                                widget.focusNodes[item.key - 1].requestFocus();
                                // widget.focusNodes[item.key + 1].requestFocus();
                              } else {
                                widget.focusNodes[0].requestFocus();
                              }
                            } else {
                              if (item.key < widget.otpLen - 1) {
                                FocusScope.of(item.value.currentContext!)
                                    .unfocus();
                                Timer(Duration(seconds: 2), () {
                                  widget.focusNodes[item.key + 1]
                                      .requestFocus();
                                });
                                // widget.focusNodes[item.key + 1].requestFocus();
                              } else {
                                FocusManager.instance.primaryFocus?.unfocus();
                                print("submit otp");
                              }
                            }
                            setState(() {
                              otpVal[item.key] = value;
                              // phoneValue = value;
                            });
                          },
                        ),
                      ),
                    ))
                .toList(),
            // Flexible(
            //   flex: 1,
            //   child: otpFetchedFromSms
            //       ? ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //             padding: const EdgeInsets.all(13),
            //             elevation: 0,
            //             backgroundColor: const Color.fromRGBO(58, 100, 61, 1),
            //             foregroundColor: const Color.fromRGBO(214, 248, 184, 1),
            //             shape: const RoundedRectangleBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(10)),
            //             ),
            //           ),
            //           child: const Icon(
            //             Icons.arrow_forward_rounded,
            //             size: 30,
            //           ),
            //           onPressed: () {},
            //         )
            //       : const Center(
            //           child: CircularProgressIndicator(),
            //         ),
            // ),
          ],
        ),
      ],
    );
  }
}

class ResendOtpButton extends StatelessWidget {
  const ResendOtpButton(this.remainingTimeInSec, this.countryCode, this.phone,
      this.restartTimerHandler,
      {super.key});
  final int remainingTimeInSec;
  final String countryCode;
  final String phone;
  final Function restartTimerHandler;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return OutlinedButton(
      onPressed: auth.isLoading || remainingTimeInSec > 0
          ? null
          : () {
              auth.signinWithPhone(
                  context, countryCode, phone, restartTimerHandler);
              if (!auth.isLoading) {
                restartTimerHandler();
              }
            },
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color.fromRGBO(243, 244, 247, 1),
            width: 3,
          ),
        ),
      ).merge(
        ButtonStyle(
          elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
              // if the button is pressed the elevation is 10.0, if not
              // it is 5.0
              if (states.contains(MaterialState.pressed)) return 0;
              return 0;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              // if the button is pressed the elevation is 10.0, if not
              // it is 5.0
              if (states.contains(MaterialState.pressed)) {
                return const Color.fromRGBO(0, 0, 0, 0.09);
              } else if (states.contains(MaterialState.disabled)) {
                return const Color.fromRGBO(0, 0, 0, 0.05);
              }
              return const Color.fromRGBO(255, 255, 255, 1);
            },
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              children: [
                if (remainingTimeInSec == 0)
                  Center(
                    child: auth.isLoading
                        ? Container(
                            height: 20,
                            width: 20,
                            child: const CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          )
                        : Text(
                            "Resend OTP",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(104, 172, 108, 1),
                              ),
                            ),
                          ),
                  ),
                if (remainingTimeInSec > 0) ...[
                  Text(
                    "(",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(104, 172, 108, 1),
                      ),
                    ),
                  ),
                  TimerWidget(timeInSeconds: remainingTimeInSec),
                  Text(
                    ")",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(104, 172, 108, 1),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TimerWidget extends StatelessWidget {
  final int timeInSeconds;
  const TimerWidget({required this.timeInSeconds, super.key});

  final String remainingMins = "";
  final String remainingSeconds = "";

  // @override
  @override
  Widget build(BuildContext context) {
    return Text(
      "${(timeInSeconds / 60).toStringAsFixed(0).padLeft(1, '0')}:${(timeInSeconds % 60).toStringAsFixed(0).padLeft(2, '0')}",
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(104, 172, 108, 1),
        ),
      ),
    );
  }
}
