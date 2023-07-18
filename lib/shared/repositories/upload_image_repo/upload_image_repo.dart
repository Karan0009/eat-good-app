import 'dart:io';

import 'package:login_screen_2/shared/models/image_details.dart';

abstract class UploadImageRepo {
  Future<ImageDetails> uploadImage(
    File imageFile,
    String destinationFolder, {
    String fileName = "",
  });

  Future<bool> deleteImage(String imagePath);
}
