import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_screen_2/screens/login_otp_screen.dart';
import 'package:login_screen_2/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _uid = "";
  String get uid => _uid;

  /* CONSTANT KEYS FOR SHARED PREFERENCE */
  final String _userDataKey = "userdata";
  final String _isSignedInKey = "is_signed_in";
  final String _usersCollectionName = "users";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  AuthProvider() {
    checkSignIn();
  }

  void checkSignIn() async {
    try {
      _isLoading = true;
      notifyListeners();
      final SharedPreferences sp = await SharedPreferences.getInstance();
      _isSignedIn = sp.getBool("is_signed_in") ?? false;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void signinWithPhone(BuildContext context, String countryCode,
      String phoneNumber, Function restartOtpTimerHandler) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "$countryCode$phoneNumber",
        verificationCompleted: (phoneAuthCredential) async {
          _isLoading = false;
          notifyListeners();
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          _isLoading = false;
          notifyListeners();
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          _isLoading = false;
          notifyListeners();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LoginOtpScreen(verificationId, countryCode, phoneNumber),
            ),
          );
          restartOtpTimerHandler();
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _isLoading = false;
          notifyListeners();
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String userOtp,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      _isLoading = false;
      notifyListeners();
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      showSnackBar(context, e.message.toString());
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      showSnackBar(context, e.toString());
    }
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection(_usersCollectionName)
        .doc(_uid)
        .get();
    if (snapshot.exists) {
      return true;
    }
    return false;
  }

  void saveUserDataToFirebase(
      {required BuildContext context,
      required UserModel user,
      required Function onSuccess}) async {
    _isLoading = true;
    notifyListeners();
    try {
      user.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      user.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!.toString();
      user.uid = _firebaseAuth.currentUser!.uid;
      await _firebaseFirestore
          .collection(_usersCollectionName)
          .doc(user.uid)
          .set(user.toMap());
      bool isUserDataSaved = await saveUserDataInSharedPref(user);
      if (!isUserDataSaved) {
        throw Exception("could not save data in shared pref");
      }
      bool isSignedInValueSet = await setIsSignedIn(true);
      if (!isSignedInValueSet) {
        throw Exception("could not save data in shared pref");
      }

      _isLoading = false;
      notifyListeners();
      onSuccess();
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      showSnackBar(context, e.message.toString());
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      showSnackBar(context, e.toString());
    }
  }

  Future<bool> saveUserDataInSharedPref(UserModel user) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(_userDataKey, jsonEncode(user.toMap()));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setIsSignedIn(bool value) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setBool(_isSignedInKey, value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
