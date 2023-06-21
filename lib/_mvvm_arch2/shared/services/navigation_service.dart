import 'package:flutter/material.dart';

class NavigationService {
  NavigationService();

  GlobalKey<NavigatorState> rootNavKey = GlobalKey();

  NavigatorState get nav {
    final val = rootNavKey.currentState;
    if (val != null) return val;
    throw Exception(
        'NavigatorState is not accessible. Ensure that rootNavKey has a valid context.');
  }
}
