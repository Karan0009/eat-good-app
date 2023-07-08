import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerWidget extends StatelessWidget {
  final int timeInSeconds;
  const TimerWidget({required this.timeInSeconds, super.key});

  final String remainingMins = "";
  final String remainingSeconds = "";

  // @override
  @override
  Widget build(BuildContext context) {
    return Text(
      "${(timeInSeconds / 60).toStringAsFixed(0).padLeft(1, '0')}:${(timeInSeconds % 60).toStringAsFixed(0).padLeft(2, '0')}",
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(104, 172, 108, 1),
        ),
      ),
    );
  }
}
