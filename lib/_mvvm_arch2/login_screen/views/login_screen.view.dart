// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/view_models/login_screen.viewmodel.dart';
import 'package:login_screen_2/components/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../shared/components/custom_divider/custom_divider.dart';
import '../../shared/components/loading_screen_footer/loading_screen_footer.dart';
import '../components/phone_login_form/phone_login_form.dart';
import '../components/signup_with_google/signup_with_google.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    // Provider.of<LoginViewModel>(context,listen: false).
  }

  final phoneNumberFormKey = GlobalKey<FormState>();
  void _navigateToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height * 0.95;
    final vm = Provider.of<LoginViewModel>(context);
    // final auth = Provider.of<AuthProvider>(context, listen: true);
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
              child: Container(
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
                          PhoneLoginForm(phoneNumberFormKey),
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
                              GestureDetector(
                                onTap: () => _navigateToHome(context),
                                child: Text(
                                  "Skip Sign in",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w300,
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
