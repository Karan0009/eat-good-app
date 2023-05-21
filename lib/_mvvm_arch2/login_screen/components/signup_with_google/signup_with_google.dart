import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupWithGoogleButtonWidget extends StatelessWidget {
  const SignupWithGoogleButtonWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 53,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(
          color: const Color.fromRGBO(243, 244, 247, 1),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              "Sign Up with Google",
              style: GoogleFonts.montserrat(
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/icons/logo-google.svg',
            width: 20,
            height: 20,
            semanticsLabel: "google logo",
            color: Colors.black,
          )
          // const Icon(Icons.flutter_dash),
        ],
      ),
    );
  }
}
