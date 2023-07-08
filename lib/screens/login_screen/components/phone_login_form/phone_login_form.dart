import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen_2/screens/login_screen/view_models/login_screen.viewmodel.dart';
import 'package:login_screen_2/shared/services/app_localizations_service.dart';
import 'package:provider/provider.dart';

import '../../../../shared/components/rounded_border_on_some_sides/rounded_border_on_some_sides.dart';

class PhoneLoginForm extends StatefulWidget {
  const PhoneLoginForm(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  State<PhoneLoginForm> createState() => _PhoneLoginFormState();
}

class _PhoneLoginFormState extends State<PhoneLoginForm> {
  String phoneValue = "";
  String selectedPhoneCode = "+91";

  static const int maxPhoneLength = 10;

  bool isPhoneInputValid(String val) {
    if (!RegExp(r'^\d+$').hasMatch(val) || val.length != maxPhoneLength) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context).translate("phoneNumber"),
          style: const TextStyle(
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
              child: RoundedBorderOnSomeSidesWidget(
                borderColor: const Color.fromRGBO(242, 244, 247, 1),
                borderRadius: 10,
                borderWidth: 3.0,
                contentBackgroundColor: const Color.fromRGBO(249, 249, 250, 1),
                bottomLeft: true,
                topLeft: true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: DropdownButton(
                    value: selectedPhoneCode,
                    items: vm.getPhoneCodes().map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPhoneCode = value ?? '+91';
                        vm.setPhoneDetails(selectedPhoneCode, null);
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
                      padding: const EdgeInsets.only(left: 10.0),
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
                            hintText: "123-456-7890",
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
                              vm.setPhoneDetails(null, phoneValue);
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
                        FocusManager.instance.primaryFocus?.unfocus();
                        try {
                          vm.getOtpHandler(context, () {});
                          // auth.signinWithPhone(
                          //     context, selectedPhoneCode, phoneValue, () {});
                        } catch (e) {
                          // print("error in login:${e.toString()}");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        elevation: 0,
                        backgroundColor: const Color.fromRGBO(58, 100, 61, 1),
                        foregroundColor: const Color.fromRGBO(214, 248, 184, 1),
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
    );
  }
}
