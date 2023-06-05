import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/home_screen/views/home_screen.view.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/views/login_screen.view.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/views/new_user_details_screen.view.dart';
import 'package:login_screen_2/screens/login_otp_screen.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case NamedRoute.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          settings: settings,
        );
      case NamedRoute.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );
      case NamedRoute.otpVerificationScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginOtpScreen("", "", ""),
          settings: settings,
        );
      case NamedRoute.newUserDetailsScreen:
        return MaterialPageRoute(
          builder: (context) => NewUserDetailsScreen(),
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

  static const String homeScreen = "/home";
  static const String loginScreen = "/login";
  static const String otpVerificationScreen = "/otp-verification";
  static const String newUserDetailsScreen = "/signup-user-details-form";
}
