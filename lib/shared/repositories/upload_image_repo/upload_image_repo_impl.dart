import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:login_screen_2/shared/config/firebase.dart';
import 'package:login_screen_2/shared/repositories/upload_image_repo/upload_image_repo.dart';

class UploadImageRepoImpl extends UploadImageRepo {
  final FirebaseStorage _firebaseStorage =
      FirebaseStorage.instanceFor(bucket: FirebaseConfig.getStorageBucketUrl());
  @override
  Future<String> uploadImage(File imageFile, String destinationFolder) async {
    try {
      final ref = _firebaseStorage.ref();
      String filePath = "$destinationFolder/${DateTime.now()}.png";
      final folder = ref.child(filePath);
      await folder.putFile(imageFile);
      String imageUrl = await folder.getDownloadURL();
      return imageUrl;
    } catch (err) {
      rethrow;
    }
  }

  // @override
  // Future<bool> deleteImage(String imageUrl)
}
