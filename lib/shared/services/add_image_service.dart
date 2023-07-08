import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/utils.dart';

class AddImageService {
  AddImageService();

  final ImagePicker _picker = ImagePicker();
  Future<XFile?> imagePickerHandler(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      return pickedFile;
    } catch (ex) {
      return null;
      // some error occured
    }
  }

  Future<CroppedFile?> editImageHandler(XFile imageData) async {
    try {
      final croppedImage = await ImageCropper().cropImage(
          sourcePath: imageData.path,
          aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
          compressQuality: 100,
          maxWidth: 500,
          maxHeight: 500,
          compressFormat: ImageCompressFormat.jpg,
          cropStyle: CropStyle.rectangle,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.black,
              statusBarColor: const Color.fromARGB(255, 58, 58, 58),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              title: 'Crop Image',
              cancelButtonTitle: 'Cancel',
              doneButtonTitle: 'Done',
              aspectRatioLockEnabled: true,
              aspectRatioPickerButtonHidden: true,
              minimumAspectRatio: 1.0,
            ),
          ]);
      return croppedImage;
    } catch (ex) {
      // some error occured
      rethrow;
    }
  }

  Future<File?> imagePickerAndCropperHandler(
      BuildContext context, ImageSource source) async {
    try {
      final pickedImage = await imagePickerHandler(source);
      if (pickedImage == null) {
        throw Exception("Image not selected");
      }
      final croppedImage = await editImageHandler(pickedImage);
      if (croppedImage == null) {
        throw Exception("Image not selected");
      }
      return File(croppedImage.path);
    } catch (ex) {
      Utils.showMaterialBanner(context, ex.toString());
      return null;
    }
  }
}
