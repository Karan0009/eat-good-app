import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/views/login_screen.view.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case NamedRoute.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const _UndefinedView(),
          settings: settings,
        );
    }
  }
}

class _UndefinedView extends StatelessWidget {
  const _UndefinedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('There is no page!'),
      ),
    );
  }
}

class NamedRoute {
  NamedRoute._();

  static const String homeScreen = "/";
  static const String loginScreen = "/login";
  static const String otpVerificationScreen = "/otp-verification";
}
