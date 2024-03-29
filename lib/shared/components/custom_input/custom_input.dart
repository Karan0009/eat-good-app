import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInput extends StatelessWidget {
  final Function onChangeHandler;
  final String label;
  final String placeholder;
  final String value;
  final int? maxLength;
  final bool? enabled;
  final String? Function(String?)? validator;
  const CustomInput(
      {super.key,
      required this.label,
      required this.placeholder,
      required this.onChangeHandler,
      required this.value,
      this.enabled,
      this.validator,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color.fromRGBO(
              102,
              112,
              133,
              enabled == null || enabled! ? 1 : 0.4,
            ),
            fontSize: 10,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.only(left: 20.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(249, 249, 250, 1),
            border: Border.all(
              color: const Color.fromRGBO(242, 244, 247, 1),
              width: 3,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: TextFormField(
            maxLength: maxLength,
            enabled: enabled ?? true,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: Color.fromRGBO(
                  102,
                  112,
                  133,
                  enabled == null || enabled! ? 1 : 0.4,
                ),
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: placeholder,
              counterText: "",
              hintStyle: const TextStyle(
                color: Color.fromRGBO(102, 112, 133, 0.5),
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            validator: validator ?? (value) => null,
            initialValue: value,
            onChanged: (value) {
              // if (isPhoneInputValid(value)) {
              onChangeHandler(value);
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
      ],
    );
  }
}
