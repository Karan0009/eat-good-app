import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:login_screen_2/shared/config/firebase.dart';
import 'package:login_screen_2/shared/models/image_details.dart';
import 'package:login_screen_2/shared/repositories/upload_image_repo/upload_image_repo.dart';

class UploadImageRepoImpl extends UploadImageRepo {
  final FirebaseStorage _firebaseStorage =
      FirebaseStorage.instanceFor(bucket: FirebaseConfig.getStorageBucketUrl());
  @override
  Future<ImageDetails> uploadImage(
    File imageFile,
    String destinationFolder, {
    String fileName = "",
  }) async {
    try {
      final ref = _firebaseStorage.ref();
      String fileNameToUse = fileName == ""
          ? DateTime.now().millisecondsSinceEpoch.toString()
          : fileName;
      String filePath = "$destinationFolder/$fileNameToUse.png";
      final folder = ref.child(filePath);
      await folder.putFile(imageFile);
      String imageUrl = await folder.getDownloadURL();
      final metaData = await folder.getMetadata();
      return ImageDetails(url: imageUrl, path: metaData.fullPath);
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteImage(String imagePath) async {
    try {
      final storageRef = _firebaseStorage.ref();
      final imageRef = storageRef.child(imagePath);
      await imageRef.delete();
      return true;
    } catch (err) {
      rethrow;
    }
  }
}
