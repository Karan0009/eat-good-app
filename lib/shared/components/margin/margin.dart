import 'package:flutter/material.dart';

class Margin extends StatelessWidget {
  final double height;

  const Margin({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
