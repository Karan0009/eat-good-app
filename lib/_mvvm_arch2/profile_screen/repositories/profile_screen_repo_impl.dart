import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_screen_2/_mvvm_arch2/locator.dart';
import 'package:login_screen_2/_mvvm_arch2/profile_screen/repositories/profile_screen_repo.dart';

class ProfileScreenRepoImpl implements ProfileScreenRepo {
  final FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();

  @override
  Future<bool> logoutUser() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (ex) {
      rethrow;
    }
  }
}
