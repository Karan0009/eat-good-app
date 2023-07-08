import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_screen_2/locator.dart';
import 'package:login_screen_2/login_screen/models/phone_details.dart';
import 'package:login_screen_2/login_screen/repositories/login_screen_repo.dart';
import 'package:login_screen_2/shared/models/user_model.dart';

import '../../shared/config/firebase.dart';

class LoginScreenRepoImpl implements LoginScreenRepo {
  final FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();
  final FirebaseFirestore _firebaseFirestore = locator<FirebaseFirestore>();
  late String _verificationId;

  LoginScreenRepoImpl();

  @override
  Future<void> sendOtpWithFirebase(
      PhoneDetails phoneDetails,
      Function verificationFailedCallback,
      Function codeSentCallback,
      Function verificationCompletedCallback) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneDetails.getCompletePhoneNumber(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This callback will be triggered when the verification is completed automatically
          // For example, if Firebase can automatically detect the SMS code sent to the phone number
          await _firebaseAuth.signInWithCredential(credential);
          verificationCompletedCallback(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          verificationFailedCallback(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          // This callback will be triggered when the verification code is successfully sent to the phone number
          // Save the verification ID for later use (when user enters the verification code)
          _verificationId = verificationId;
          codeSentCallback(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // This callback will be triggered when the automatic code retrieval times out
          // Handle the timeout accordingly
          _verificationId = verificationId;
          // codeSentCallback(_verificationId);
        },
      );
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<User?> signInWithVerificationCode(String smsCode) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      User? user = (await _firebaseAuth.signInWithCredential(credential)).user;
      return user;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<bool> checkExistingUser(String userId) async {
    try {
      String userCollectionName = FirebaseConfig.getCollectionName("users");

      DocumentSnapshot snapshot = await _firebaseFirestore
          .collection(userCollectionName)
          .doc(userId)
          .get();
      if (snapshot.exists) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> saveNewUserDataWithFirestore(CustomUser user) async {
    try {
      String userCollectionName = FirebaseConfig.getCollectionName("users");

      if (user.phoneNumber != "" &&
          user.firstName != "" &&
          user.firebaseUser != null) {
        final uid = user.firebaseUser?.uid;
        await _firebaseFirestore
            .collection(userCollectionName)
            .doc(uid)
            .set(user.toJson());
        return true;
      }
      return false;
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getUserById(String uid) async {
    try {
      String userCollectionName = FirebaseConfig.getCollectionName("users");

      if (uid == "") {
        throw Exception("uid cannot be empty");
      }

      DocumentSnapshot snapshot = await _firebaseFirestore
          .collection(userCollectionName)
          .doc(uid)
          .get();
      if (!snapshot.exists) {
        throw Exception("user not found");
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data;
    } catch (ex) {
      rethrow;
    }
  }
}
