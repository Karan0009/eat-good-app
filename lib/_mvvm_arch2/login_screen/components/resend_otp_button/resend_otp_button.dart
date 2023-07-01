import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/models/phone_details.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/view_models/login_screen.viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../shared/services/app_localizations_service.dart';
import '../otp_timer/timer_widget.dart';

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
    final vm = Provider.of<LoginViewModel>(context, listen: true);
    return OutlinedButton(
      onPressed: vm.isLoading || remainingTimeInSec > 0
          ? null
          : () {
              vm.getOtpHandler(
                context,
                () {},
                otherPhoneDetails: PhoneDetails(
                  phoneNumber: phone,
                  countryCode: countryCode,
                ),
              );
              if (!vm.isLoading) {
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
                    child: vm.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          )
                        : Text(
                            AppLocalizations.of(context).translate("resendOtp"),
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
