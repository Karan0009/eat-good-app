import 'package:flutter/material.dart';
import 'package:login_screen_2/screens/home_screen.dart';
import 'package:login_screen_2/screens/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  "/": (BuildContext context) => const LoginScreen(),
  '/login': (BuildContext context) => const LoginScreen(),
  '/home': (BuildContext context) => const HomeScreen(),
};
