import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/services/app_localizations_service.dart';

class LoginScreenFooter extends StatelessWidget {
  const LoginScreenFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)
                    .translate("byProceddingYouAgreeToOur"),
                style: GoogleFonts.montserrat(),
              ),
              Text(
                ",",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context).translate("terms"),
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          Text(
            AppLocalizations.of(context)
                .translate("andConditionsAndPrivacyPolicy"),
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Colors.red,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
