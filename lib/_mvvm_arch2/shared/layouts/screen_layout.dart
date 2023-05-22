import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/components/loading_overlay/loading_overlay.dart';

class ScreenLayout extends StatelessWidget {
  final bool isLoading;
  final double screenHeight;
  final Widget child;
  final AppBar? appBar;
  final BottomNavigationBar? bottomNavigationBar;
  const ScreenLayout(
      {required this.isLoading,
      required this.screenHeight,
      required this.child,
      this.appBar,
      this.bottomNavigationBar,
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
          appBar: appBar,
          bottomNavigationBar: bottomNavigationBar,
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
