import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/models/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  CustomUser? _user;
  CustomUser? get user => _user;

  void setLoggedInUser(CustomUser newUser) async {
    _user = newUser;
    // await _saveDataInLocalStorage(user);
    notifyListeners();
  }

  // Future<void> _saveDataInLocalStorage(User? user) async {
  //   try {
  //     final SharedPreferences sp = await SharedPreferences.getInstance();
  //   } catch (ex) {
  //     rethrow;
  //   }
  // }
}
