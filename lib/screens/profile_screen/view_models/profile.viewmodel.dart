import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_screen_2/screens/profile_screen/repositories/profile_screen_repo.dart';
import 'package:login_screen_2/shared/routes/routes.dart';
import 'package:login_screen_2/shared/services/add_image_service.dart';

import '../../../locator.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../shared/services/navigation_service.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/view_models/loading.viewmodel.dart';
import '../../view_profile_photo_screen/models/view_profile_photo_screen_arguments.dart';
import '../models/menu_item_model.dart';

class ProfileScreenViewModel extends LoadingViewModel {
  ProfileScreenViewModel({required this.profileRepo}) : super();

  final ProfileScreenRepo profileRepo;
  final UserProvider _userProvider = locator<UserProvider>();
  final NavigationService _navService = locator<NavigationService>();
  final AddImageService _addImageService = locator<AddImageService>();

  File profilePictureFile = File("");
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
    ),
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
      _showProfilePictureOptionsBottomModelItemsList = [
    {"label": "View"},
    {"label": "Delete"},
    {"label": "Edit"},
    {"label": "Cancel"},
  ];

  final List<Map<String, dynamic>> _showImageSourceBottomModelItemsList = [
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
          itemCount: _showProfilePictureOptionsBottomModelItemsList.length,
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
                  _showProfilePictureOptionsBottomModelItemsList[index]
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
          itemCount: _showImageSourceBottomModelItemsList.length,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () async {
                switch (index) {
                  case 0:
                    _addImageService
                        .imagePickerAndCropperHandler(
                            context, ImageSource.camera)
                        .then((value) {
                      if (value != null) {
                        closeBottamModalHandler(context);
                        profilePictureFile = value;
                        notifyListeners();
                      }
                    });
                    break;
                  case 1:
                    _addImageService
                        .imagePickerAndCropperHandler(
                            context, ImageSource.gallery)
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
                  _showImageSourceBottomModelItemsList[index]["label"] ?? "",
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
    if (profilePictureFile.path != "") {
      _navService.nav.pushNamed(
        NamedRoute.viewProfilePhotoScreen,
        arguments:
            ViewProfilePhotoScreenArguments(imageFile: profilePictureFile),
      );
    }
  }

  deleteProfilePhotoHandler(BuildContext context) {
    if (profilePictureFile.path == "") {
      return;
    }
    closeBottamModalHandler(context);
    Utils.showMaterialBanner(
      context,
      "Are you sure?",
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            showProfilePictureOptionsBottomModel(context);
          },
        ),
        TextButton(
          child: const Text('Delete'),
          onPressed: () {
            // Perform delete operation
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
      autoCloseDuration: const Duration(seconds: 30),
    );
  }

  editProfilePhotoHandler(BuildContext context) {
    closeBottamModalHandler(context);
    showImageSourceSelector(context);
  }

  closeBottamModalHandler(BuildContext context) {
    _navService.nav.pop();
  }
}
