import '../../models/user_model.dart';

abstract class UserRepository {
  Future<bool> checkExistingUser(String userId);

  Future<bool> saveNewUserDataWithFirestore(CustomUser user);

  Future<Map<String, dynamic>> getUserById(String uid);

  Future<bool> updateGeneralUserDataInFirestore(CustomUser updatedUser);

  Future<bool> updateProfilePictureInFirestore(String uid, String imageUrl);
}
