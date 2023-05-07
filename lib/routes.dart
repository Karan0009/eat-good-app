import 'package:flutter/material.dart';
import 'package:login_screen_2/screens/home_screen.dart';
import 'package:login_screen_2/screens/login_otp_screen.dart';
import 'package:login_screen_2/screens/login_screen.dart';
import 'package:login_screen_2/screens/new_user_details_screen.dart';
import 'package:login_screen_2/screens/home_screen_profile_nav.dart';

final Map<String, WidgetBuilder> routes = {
  '/login': (BuildContext context) => const LoginScreen(),
  '/login-get-otp': (BuildContext context) => const LoginOtpScreen("", "", ""),
  '/home': (BuildContext context) => const HomeScreen(initalIndex: 0),
  '/new-user-details': (BuildContext context) => NewUserDetailsScreen(),
  '/profile': (BuildContext context) => const ProfileScreen()
};
