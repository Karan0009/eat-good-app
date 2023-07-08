import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  final double screenHeight;
  final Widget child;
  const PageLayout(
      {required this.screenHeight, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SizedBox(
          height: screenHeight,
          // decoration: const BoxDecoration(color: Colors.yellow),
          child: child,
        ),
      ),
    );
  }
}
