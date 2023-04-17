import 'package:flutter/material.dart';

import '../loading_overlay.dart';

class ScreenLayout extends StatelessWidget {
  final bool isLoading;
  final double screenHeight;
  final Widget child;
  const ScreenLayout(
      {required this.isLoading,
      required this.screenHeight,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SizedBox(
                  height: screenHeight,
                  // decoration: const BoxDecoration(color: Colors.yellow),
                  child: child),
            ),
          ),
        ),
      ),
    );
  }
}
