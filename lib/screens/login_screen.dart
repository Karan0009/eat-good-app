// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_screen_2/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../components/login_screen_footer.dart';
import '../components/rounded_border_on_some_sides_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _navigateToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  final phoneNumberFormKey = GlobalKey<FormState>();
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
                        PhoneLoginForm(phoneNumberFormKey),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     // Text("hello"),
                        //     Expanded(
                        //       flex: 4,
                        //       child: CustomInput(phoneNumberFormKey),
                        //     ),
                        //     Expanded(
                        //       flex: 1,
                        //       child: ElevatedButton(
                        //         onPressed: () {},
                        //         style: ElevatedButton.styleFrom(
                        //           // padding: const EdgeInsets.all(10),
                        //           elevation: 0,
                        //           backgroundColor:
                        //               const Color.fromRGBO(58, 100, 61, 1),
                        //           foregroundColor:
                        //               const Color.fromRGBO(214, 248, 184, 1),
                        //           shape: const RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.only(
                        //               topRight: Radius.circular(10),
                        //               bottomRight: Radius.circular(10),
                        //             ),
                        //           ),
                        //         ),
                        //         child: const Icon(
                        //           Icons.arrow_forward_rounded,
                        //           size: 30,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
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

class CustomInput extends StatefulWidget {
  const CustomInput(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  String phoneValue = "";
  static const int maxPhoneLength = 10;

  bool isPhoneInputValid(String val) {
    if (!RegExp(r'\d').hasMatch(val) || val.length > maxPhoneLength) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(color: Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Phone Number: $phoneValue',
            style: const TextStyle(
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
                color: const Color.fromRGBO(242, 244, 247, 1),
                width: 3,
              ),
              // border: Border(
              //   top: BorderSide(
              //     width: 3.0, color: Colors.red,
              //     // color: Color.fromRGBO(242, 244, 247, 1),
              //   ),
              //   left: BorderSide(
              //     width: 1.0,
              //     color: Color.fromRGBO(242, 244, 247, 1),
              //   ),
              //   bottom: BorderSide(
              //     width: 1.0,
              //     color: Color.fromRGBO(242, 244, 247, 1),
              //   ),
              //   right: BorderSide.none,
              // ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Form(
                key: widget.formKey,
                child: TextFormField(
                  maxLength: 10,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(102, 112, 133, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "132-456-7890",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(102, 112, 133, 0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  validator: (value) {
                    return null;
                    // if (value!.isEmpty ||
                    //     !RegExp(r'\d{10}').hasMatch(value)) {
                    //   return 'Please enter valid phone number';
                    // }
                    // return null;
                  },
                  onChanged: (value) {
                    if (isPhoneInputValid(value)) {
                      setState(() {
                        phoneValue = value;
                      });
                    } else {
                      print("input is invalid");
                    }
                    // if (widget.formKey.currentState!.validate()) {
                    //   print("form is valid");
                    // } else {
                    //   print("form is not valid");
                    // }
                    // if(formKey.is)
                    // print(value);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneLoginForm extends StatefulWidget {
  const PhoneLoginForm(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  State<PhoneLoginForm> createState() => _PhoneLoginFormState();
}

class _PhoneLoginFormState extends State<PhoneLoginForm> {
  String phoneValue = "";
  String selectedPhoneCode = "+91";
  List<String> phoneCodes = ["+91", "+10"];
  static const int maxPhoneLength = 10;

  bool isPhoneInputValid(String val) {
    if (!RegExp(r'^\d+$').hasMatch(val) || val.length != maxPhoneLength) {
      return false;
    } else {
      return true;
    }
  }

  void navigateToLoginOtpScreen(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    auth.signinWithPhone(context, selectedPhoneCode, phoneValue);
    // Navigator.pushNamed(context, '/login-get-otp',
    //     arguments: {'countryCode': selectedPhoneCode, 'phone': phoneValue});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(color: Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Phone Number',
            style: TextStyle(
              color: Color.fromRGBO(102, 112, 133, 1),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                // child:
                // ClipRRect(
                //   borderRadius: const BorderRadius.only(
                //     topLeft: Radius.circular(10),
                //     bottomLeft: Radius.circular(10),
                //   ),

                child: RoundedBorderOnSomeSidesWidget(
                  borderColor: const Color.fromRGBO(242, 244, 247, 1),
                  borderRadius: 10,
                  borderWidth: 3.0,
                  contentBackgroundColor:
                      const Color.fromRGBO(249, 249, 250, 1),
                  bottomLeft: true,
                  topLeft: true,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: DropdownButton(
                      value: selectedPhoneCode,
                      items: phoneCodes.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPhoneCode = value ?? '+91';
                        });
                      },
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(102, 112, 133, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      elevation: 0,
                      underline: Container(
                        height: 0,
                        color: Colors.blue,
                      ),
                      isExpanded: true,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Positioned(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(249, 249, 250, 1),
                          border: Border.all(
                            color: const Color.fromRGBO(242, 244, 247, 1),
                            width: 3,
                          ),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Form(
                          key: widget.formKey,
                          child: TextFormField(
                            maxLength: 10,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Color.fromRGBO(102, 112, 133, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            autofocus: true,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "132-456-7890",
                              counterText: "",
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(102, 112, 133, 0.5),
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            validator: (value) {
                              return null;
                              // if (value!.isEmpty ||
                              //     !RegExp(r'\d{10}').hasMatch(value)) {
                              //   return 'Please enter valid phone number';
                              // }
                              // return null;
                            },
                            onChanged: (value) {
                              // if (isPhoneInputValid(value)) {
                              setState(() {
                                phoneValue = value;
                              });
                              // }
                              // } else {
                              //   print("input is invalid");
                              // }
                              // if (widget.formKey.currentState!.validate()) {
                              //   print("form is valid");
                              // } else {
                              //   print("form is not valid");
                              // }
                              // if(formKey.is)
                              // print(value);
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isPhoneInputValid(phoneValue),
                      child: ElevatedButton(
                        onPressed: () {
                          navigateToLoginOtpScreen(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          elevation: 0,
                          backgroundColor: const Color.fromRGBO(58, 100, 61, 1),
                          foregroundColor:
                              const Color.fromRGBO(214, 248, 184, 1),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
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
