import 'package:flutter/material.dart';
import 'package:login_screen_2/screens/home_screen.dart';
import 'package:login_screen_2/screens/login_otp_screen.dart';
import 'package:login_screen_2/screens/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  "/": (BuildContext context) => const LoginOtpScreen("", "", ""),
  '/login': (BuildContext context) => const LoginScreen(),
  '/login-get-otp': (BuildContext context) => const LoginOtpScreen("", "", ""),
  '/home': (BuildContext context) => const HomeScreen(),
};
