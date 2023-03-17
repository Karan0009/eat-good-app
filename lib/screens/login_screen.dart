// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
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
                          "Welcome to",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(fontSize: 30),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Untitled",
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(fontSize: 30),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        CustomInput(),
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            const CustomDivider(
                              colors: [
                                Color.fromRGBO(0, 0, 0, 0),
                                Color.fromRGBO(0, 0, 0, 1),
                                Color.fromRGBO(0, 0, 0, 0)
                              ],
                              thickness: 1,
                            ),
                            Container(
                              width: 30,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const Center(
                                child: Text(
                                  "Or",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SignupWithGoogleButtonWidget(),
                        const SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Skip Sign in",
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w300,
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
                    child: Footer(),
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

class CustomDivider extends StatelessWidget {
  final double thickness;
  final List<Color> colors;

  const CustomDivider(
      {super.key, required this.thickness, required this.colors});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: thickness,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
          ),
        ),
      ),
    );
  }
}

class CustomInput extends StatelessWidget {
  const CustomInput({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Phone Number",
              style: TextStyle(
                color: Color.fromRGBO(102, 112, 133, 1),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(249, 249, 250, 1),
                border: Border.all(
                  color: const Color.fromRGBO(243, 244, 247, 1),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Form(
                  child: TextFormField(
                    style: const TextStyle(
                      color: Color.fromRGBO(102, 112, 133, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "+91 132-456-7890",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(102, 112, 133, 0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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
          const Icon(Icons.flutter_dash),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

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
