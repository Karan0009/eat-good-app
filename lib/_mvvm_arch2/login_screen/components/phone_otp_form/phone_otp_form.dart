import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    super.initState();
    // currentFocusNode = widget.focusNodes[0];
    // try {
    //   currentFocusNode?.requestFocus();
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  @override
  Widget build(BuildContext context) {
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
                            widget.focusNodes[item.key].requestFocus();
                          },
                          onChanged: (value) {
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
                                Timer(const Duration(seconds: 2), () {
                                  widget.focusNodes[item.key + 1]
                                      .requestFocus();
                                });
                                // widget.focusNodes[item.key + 1].requestFocus();
                              } else {
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                            }
                            setState(() {
                              otpVal[item.key] = value;
                            });
                          },
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ],
    );
  }
}
