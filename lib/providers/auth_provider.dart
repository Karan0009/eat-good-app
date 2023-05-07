import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_screen_2/screens/login_otp_screen.dart';
import 'package:login_screen_2/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated
}

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthStatus _authStatus = AuthStatus.uninitialized;
  AuthStatus get authStatus => _authStatus;

  String _uid = "";
  String get uid => _uid;

  UserModel _user = UserModel(
      firstName: "", createdAt: "", lastName: "", phoneNumber: "", uid: "");
  UserModel get user => _user;

  final TextEditingController _pinController = TextEditingController();
  TextEditingController get pinController => _pinController;

  /* CONSTANT KEYS FOR SHARED PREFERENCE */
  final String _userDataKey = "userdata";
  final String _usersCollectionName = "users";
  final String _isSignedInKey = "is_signed_in";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  AuthProvider() {
    // _firebaseAuth.authStateChanges().listen(_onAuthStateChanged);
    checkSignIn();
  }

  void checkSignIn() async {
    _isLoading = true;
    notifyListeners();
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      String userData = sp.getString(_userDataKey) ?? "";
      if (userData != "") {
        final userData = jsonDecode(sp.getString(_userDataKey)!);
        _uid = userData["uid"];
        _user.uid = _uid;
        _user.firstName = userData["firstName"];
        _user.lastName = userData["lastName"];
        _user.phoneNumber = userData["phoneNumber"];
        _user.createdAt = userData["createdAt"];
        _authStatus = AuthStatus.authenticated;
        // await _firebaseAuth.signInWithCustomToken(_uid);
      } else {
        _uid = "";
        _authStatus = AuthStatus.unauthenticated;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

  void _onAuthStateChanged(User? user) {
    if (user == null) {
      _authStatus = AuthStatus.unauthenticated;
    } else {
      _authStatus = AuthStatus.authenticated;
    }
    notifyListeners();
  }

  void signinWithPhone(BuildContext context, String countryCode,
      String phoneNumber, Function restartOtpTimerHandler) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "$countryCode$phoneNumber",
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          _isLoading = false;
          notifyListeners();
          pinController.text = phoneAuthCredential.smsCode.toString();
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
      _isLoading = false;
      notifyListeners();
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyOtpAndSaveUser(
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
      if (user != null) {
        _uid = user.uid;
        bool doesUserExists = await checkExistingUser();
        if (doesUserExists) {
          UserModel? user = await _getDataOfUserByUid(uid);
          if (user == null) {
            throw Exception("user cannot be found");
          }
          bool isUserDataSaved = await saveUserDataInSharedPref(user);
          if (!isUserDataSaved) {
            throw Exception("error in saving user data");
          }
          _authStatus = AuthStatus.authenticated;
        }
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
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

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel user,
    required Function onSuccess,
  }) async {
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
      _authStatus = AuthStatus.authenticated;

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
      _user = user;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeUserDataFromSharedPref() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(_userDataKey, "");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> _getDataOfUserByUid(String uid) async {
    _isLoading = true;
    notifyListeners();
    try {
      var snapshot = await _firebaseFirestore
          .collection(_usersCollectionName)
          .doc(uid)
          .get();
      if (snapshot.exists) {
        _isLoading = false;
        notifyListeners();
        return UserModel.fromMap(snapshot.data()!);
      } else {
        _isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
    _authStatus = AuthStatus.unauthenticated;
    _uid = "";
    _user = UserModel(
        firstName: "", createdAt: "", lastName: "", phoneNumber: "", uid: "");
    await removeUserDataFromSharedPref();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  // Future<bool> setIsSignedIn(bool value) async {
  //   try {
  //     final SharedPreferences sp = await SharedPreferences.getInstance();
  //     sp.setBool(_isSignedInKey, value);
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
