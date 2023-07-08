import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/home_screen/views/home_screen.view.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/views/login_screen.view.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/views/new_user_details_screen.view.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/views/otp_verification_screen.view.dart';
import 'package:login_screen_2/_mvvm_arch2/profile_screen/views/profile_screen.view.dart';

import '../../home_screen/models/home_page_view_arguments.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case NamedRoute.homeScreen:
        if (args is HomePageViewArguments) {
          return MaterialPageRoute(
            builder: (context) => HomeScreen(data: args),
            settings: settings,
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => const _UndefinedView(),
            settings: settings,
          );
        }
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
      case NamedRoute.profileScreen:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
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
  static const String profileScreen = "/profile";
}
