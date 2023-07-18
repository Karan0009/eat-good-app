import 'package:login_screen_2/shared/models/image_details.dart';

class AppConstants {
  AppConstants._();

  static const String userInfoKey = "userInfo";
  static const ImageDetails defaultProfilePhoto = ImageDetails(
    url:
        "https://firebasestorage.googleapis.com/v0/b/eat-good-98f6d.appspot.com/o/default_pictures%2Fprofile_cover_illustration.png?alt=media&token=9b3364e8-489c-48fa-9852-4fba91896d7e",
    path: "default_pictures/profile_cover_illustrations.png",
  );
}
