import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_screen_2/shared/models/image_details.dart';
import 'package:login_screen_2/shared/repositories/user_repo/user_repo.dart';

import '../../../locator.dart';
import '../../config/firebase.dart';
import '../../models/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseFirestore _firebaseFirestore = locator<FirebaseFirestore>();

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
        final uid = user.firebaseUser;
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

  @override
  Future<bool> updateGeneralUserDataInFirestore(CustomUser updatedUser) async {
    try {
      String userCollectionName = FirebaseConfig.getCollectionName("users");
      final uid = updatedUser.firebaseUser;
      DocumentReference doc =
          _firebaseFirestore.collection(userCollectionName).doc(uid);
      await doc.update({
        "firstName": updatedUser.firstName,
        "lastName": updatedUser.lastName,
      });
      return true;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<bool> updateProfilePictureInFirestore(
      String uid, ImageDetails imageDetails) async {
    try {
      String userCollectionName = FirebaseConfig.getCollectionName("users");
      DocumentReference doc =
          _firebaseFirestore.collection(userCollectionName).doc(uid);
      await doc.update({
        "profilePhoto": imageDetails.toJson(),
      });
      return true;
    } catch (err) {
      rethrow;
    }
  }

  // Future<bool> deleteExistingPhotoInFiresotre(String uid) async {
  //   try {
  //     final user = await getUserById(uid);
  //     if (user["profilePicture"] != null) {

  //     }
  //     return true;
  //   } catch (err) {
  //     rethrow;
  //   }
  // }
}
