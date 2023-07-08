import 'dart:async';

import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static void showMaterialBanner(BuildContext context, String message,
      {List<Widget> actions = const [Text("Cancel")],
      Duration autoCloseDuration = const Duration(seconds: 5)}) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(message),
        actions: actions,
        onVisible: () {
          Timer(
            autoCloseDuration,
            () {
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
