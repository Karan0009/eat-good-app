import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>
      showMaterialBanner(BuildContext context, String message,
          {List<Widget> actions = const [Text("Cancel")],
          Duration autoCloseDuration = const Duration(seconds: 5),
          TextStyle messageStyle = const TextStyle(
            color: Colors.black,
            fontSize: 14,
          )}) {
    return ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(
          message,
          style: messageStyle,
        ),
        actions: actions,
      ),
    );
  }
}
