import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:login_screen_2/_mvvm_arch2/profile_screen/repositories/profile_screen_repo.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/routes/routes.dart';

import '../../locator.dart';
import '../../shared/providers/user_provider.dart';
import '../../shared/services/navigation_service.dart';
import '../../shared/utils/utils.dart';
import '../../shared/view_models/loading.viewmodel.dart';
import '../models/menu_item_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreenViewModel extends LoadingViewModel {
  ProfileScreenViewModel({required this.profileRepo}) : super();

  final ProfileScreenRepo profileRepo;
  final UserProvider _userProvider = locator<UserProvider>();
  final NavigationService _navService = locator<NavigationService>();

  final List<MenuItemModel> _menuItems = [
    MenuItemModel(
      icon: 'assets/icons/profile_details_icon.svg',
      title: "profileDetails",
    ),
    MenuItemModel(
      icon: 'assets/icons/places_icon.svg',
      title: "placesAdded",
    ),
    MenuItemModel(
      icon: 'assets/icons/profile_reviews_icon.svg',
      title: "yourReviews",
    ),
    MenuItemModel(
      icon: 'assets/icons/profile_saved_places_icon.svg',
      title: "savedPlaces",
    ),
    MenuItemModel(
      icon: 'assets/icons/profile_settings_icon.svg',
      title: "generalPreferences",
    ),
    MenuItemModel(
      icon: 'assets/icons/profile_feedback_icon.svg',
      title: "feedback",
    )
  ];

  Future<void> logoutButtonClickHandler(BuildContext context) async {
    try {
      isLoading = true;
      final res = await profileRepo.logoutUser();
      if (!res) {
        throw Exception("Error in logging out");
      }
      final isUserRemoved = await _userProvider.removeLoggedInUser();
      if (!isUserRemoved) {
        throw Exception("Error in removing saved user data");
      }
      isLoading = false;
      _navService.nav.pushNamedAndRemoveUntil(
        NamedRoute.loginScreen,
        (route) => false,
      );
    } catch (ex) {
      isLoading = false;
      Utils.showSnackBar(context, "Some error occured");
    }
  }

  loginButtonClickHandler(BuildContext context) {
    try {
      _navService.nav.pushNamedAndRemoveUntil(
        NamedRoute.loginScreen,
        (route) => false,
      );
    } catch (ex) {
      isLoading = false;
      Utils.showSnackBar(context, "Some error occured");
    }
  }

  List<MenuItemModel> getMenuItems() {
    return _menuItems;
  }

  back() {
    _navService.nav.pop();
  }

  closeModal() {
    _navService.nav.pop();
  }

  final List<Map<String, dynamic>>
      showProfilePictureOptionsBottomModelItemsList = [
    {"label": "View"},
    {"label": "Delete"},
    {"label": "Edit"},
    {"label": "Cancel"},
  ];

  final List<Map<String, dynamic>> showImageSourceBottomModelItemsList = [
    {"label": "Camera"},
    {"label": "Gallery"},
    {"label": "Cancel"},
  ];

  showProfilePictureOptionsBottomModel(BuildContext context) {
    try {
      showModalBottomSheet(
        context: context,
        useSafeArea: true,
        enableDrag: false,
        showDragHandle: false,
        isScrollControlled: false,
        backgroundColor: Colors.white,
        constraints: const BoxConstraints(maxHeight: 150),
        builder: (_) => ListView.builder(
          itemCount: showProfilePictureOptionsBottomModelItemsList.length,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    viewProfilePhotoHandler(context);
                    break;
                  case 1:
                    deleteProfilePhotoHandler(context);
                    break;
                  case 2:
                    editProfilePhotoHandler(context);
                    break;
                  case 3:
                    closeBottamModalHandler(context);
                    break;
                  default:
                    closeBottamModalHandler(context);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    )),
                child: Text(
                  showProfilePictureOptionsBottomModelItemsList[index]
                          ["label"] ??
                      "",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            );
          },
        ),
      );
    } catch (ex) {
      // some error occured
    }
  }

  showImageSourceSelector(BuildContext context) {
    try {
      showModalBottomSheet(
        context: context,
        useSafeArea: true,
        enableDrag: false,
        showDragHandle: false,
        isScrollControlled: false,
        backgroundColor: Colors.white,
        constraints: const BoxConstraints(maxHeight: 114),
        builder: (_) => ListView.builder(
          itemCount: showImageSourceBottomModelItemsList.length,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () async {
                switch (index) {
                  case 0:
                    imagePickerAndCropperHandler(context, ImageSource.camera)
                        .then((value) {
                      if (value != null) {
                        closeBottamModalHandler(context);
                        profilePictureFile = value;
                        notifyListeners();
                      }
                    });
                    break;
                  case 1:
                    imagePickerAndCropperHandler(context, ImageSource.gallery)
                        .then((value) {
                      if (value != null) {
                        closeBottamModalHandler(context);
                        profilePictureFile = value;
                        notifyListeners();
                      }
                    });
                    break;
                  case 2:
                    closeBottamModalHandler(context);
                    break;
                  default:
                    closeBottamModalHandler(context);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    )),
                child: Text(
                  showImageSourceBottomModelItemsList[index]["label"] ?? "",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            );
          },
        ),
      );
    } catch (ex) {
      // some error occured
      Utils.showSnackBar(context, "Some error occured");
    }
  }

  viewProfilePhotoHandler(BuildContext context) {
    // TODO : navigate to view profile photo page
  }

  deleteProfilePhotoHandler(BuildContext context) {
    // TODO : open alert to cancel OR sure and close this modal
  }

  editProfilePhotoHandler(BuildContext context) {
    closeBottamModalHandler(context);
    showImageSourceSelector(context);
  }

  closeBottamModalHandler(BuildContext context) {
    _navService.nav.pop();
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

  final ImagePicker _picker = ImagePicker();
  File profilePictureFile = File("");
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
          cropStyle: CropStyle.circle,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.deepOrange,
              statusBarColor: Colors.deepOrange.shade900,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: 'Crop Image',
              cancelButtonTitle: 'Cancel',
              doneButtonTitle: 'Done',
              aspectRatioLockEnabled: false,
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
}
