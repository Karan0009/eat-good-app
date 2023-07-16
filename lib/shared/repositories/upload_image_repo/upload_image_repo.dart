import 'dart:io';

abstract class UploadImageRepo {
  Future<String> uploadImage(File imageFile, String destinationFolder);
}
