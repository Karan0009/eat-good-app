import 'dart:io';

class ViewProfilePhotoScreenArguments {
  final File imageFile;

  ViewProfilePhotoScreenArguments({required this.imageFile});

  factory ViewProfilePhotoScreenArguments.fromJson(Map<String, dynamic> json) {
    return ViewProfilePhotoScreenArguments(imageFile: json["imageFile"]);
  }
}
