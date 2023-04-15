import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreenFooter extends StatelessWidget {
  const LoginScreenFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "By proceeding, you agree to our ",
                style: GoogleFonts.montserrat(),
              ),
              Text(
                "Terms",
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
            "and Conditions & Privacy Policy.",
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
