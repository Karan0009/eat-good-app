import 'package:flutter/material.dart';

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
