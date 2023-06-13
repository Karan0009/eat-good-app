import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/constants/app_constants.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  CustomUser? _user;
  CustomUser? get user => _user;

  void setLoggedInUser(CustomUser newUser) async {
    _user = newUser;
    // await _saveDataInLocalStorage(user);
    notifyListeners();
  }

  bool setFirstName(String firstName) {
    try {
      if (_user != null) {
        _user?.firstName = firstName;
        return true;
      }
      return false;
    } catch (ex) {
      _user = null;
      notifyListeners();
      return false;
    }
  }

  bool setLastName(String lastName) {
    try {
      if (_user != null) {
        _user?.lastName = lastName;
        return true;
      }
      return false;
    } catch (ex) {
      _user = null;
      notifyListeners();
      return false;
    }
  }

  Future<bool> saveLoggedInUserLocally() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      if (user != null) {
        sp.setString(AppConstants.userInfoKey, jsonEncode(user?.toJson()));
        return true;
      } else {
        throw Exception("user not found");
      }
    } catch (ex) {
      _user = null;
      notifyListeners();
      return false;
    }
  }

  Future<bool> setUserFromLocal() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      String? userInfo = sp.getString(AppConstants.userInfoKey);
      if (userInfo != null) {
        String jsonStr = userInfo;
        Map<String, dynamic> parsedJson = json.decode(jsonStr);
        _user = CustomUser.fromJson(parsedJson);
        return true;
      } else {
        throw Exception("user not found");
      }
    } catch (ex) {
      _user = null;
      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.remove(AppConstants.userInfoKey);
      notifyListeners();
      return false;
    }
  }

  // Future<void> _saveDataInLocalStorage(User? user) async {
  //   try {
  //     final SharedPreferences sp = await SharedPreferences.getInstance();
  //   } catch (ex) {
  //     rethrow;
  //   }
  // }
}
