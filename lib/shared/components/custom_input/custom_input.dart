import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInput extends StatelessWidget {
  final Function onChangeHandler;
  final String label;
  final String placeholder;
  const CustomInput({
    super.key,
    required this.label,
    required this.placeholder,
    required this.onChangeHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Color.fromRGBO(102, 112, 133, 1), fontSize: 10),
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
              maxLength: 10,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  color: Color.fromRGBO(102, 112, 133, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              autofocus: true,
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
      ),
    );
  }
}
