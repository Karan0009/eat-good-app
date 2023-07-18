import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_screen_2/screens/profile_screen/repositories/profile_screen_repo.dart';
import 'package:login_screen_2/shared/config/firebase.dart';
import 'package:login_screen_2/shared/constants/app_constants.dart';
import 'package:login_screen_2/shared/models/image_details.dart';
import 'package:login_screen_2/shared/models/user_model.dart';
import 'package:login_screen_2/shared/repositories/auth_repo/auth_repo.dart';
import 'package:login_screen_2/shared/repositories/upload_image_repo/upload_image_repo.dart';
import 'package:login_screen_2/shared/repositories/user_repo/user_repo.dart';
import 'package:login_screen_2/shared/routes/routes.dart';
import 'package:login_screen_2/shared/services/add_image_service.dart';

import '../../../locator.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../shared/services/navigation_service.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/view_models/loading.viewmodel.dart';
import '../models/menu_item_model.dart';

class ProfileScreenViewModel extends LoadingViewModel {
  ProfileScreenViewModel({
    required this.profileRepo,
    required this.uploadImageRepo,
    required this.authRepo,
    required this.userRepo,
  }) {
    isAnyAccountDetailsInputChanged = false;
  }

  final ProfileScreenRepo profileRepo;
  final UploadImageRepo uploadImageRepo;
  final AuthRepo authRepo;
  final UserRepository userRepo;

  final UserProvider _userProvider = locator<UserProvider>();
  final NavigationService _navService = locator<NavigationService>();
  final AddImageService _addImageService = locator<AddImageService>();

  File _profilePictureFile = File("");
  String? profilePictureUrl;
  set profilePictureFile(File input) {
    _profilePictureFile = input;
    notifyListeners();
  }

  File get profilePictureFile {
    return _profilePictureFile;
  }

  final List<MenuItemModel> _menuItems = [
    MenuItemModel(
      icon: 'assets/icons/profile_details_icon.svg',
      title: "profileDetails",
      link: NamedRoute.accountDetailsScreen,
    ),
    MenuItemModel(
      icon: 'assets/icons/places_icon.svg',
      title: "placesAdded",
      link: NamedRoute.accountDetailsScreen,
    ),
    MenuItemModel(
      icon: 'assets/icons/profile_reviews_icon.svg',
      title: "yourReviews",
      link: NamedRoute.accountDetailsScreen,
    ),
    MenuItemModel(
      icon: 'assets/icons/profile_saved_places_icon.svg',
      title: "savedPlaces",
      link: NamedRoute.accountDetailsScreen,
    ),
    MenuItemModel(
      icon: 'assets/icons/profile_settings_icon.svg',
      title: "generalPreferences",
      link: NamedRoute.accountDetailsScreen,
    ),
    MenuItemModel(
      icon: 'assets/icons/profile_feedback_icon.svg',
      title: "feedback",
      link: NamedRoute.accountDetailsScreen,
    ),
  ];

  Future<void> logoutButtonClickHandler(BuildContext context) async {
    try {
      isLoading = true;
      final res = await authRepo.logoutUser();
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
                    await _selectImageAndUploadHandler(
                      context,
                      ImageSource.camera,
                    );
                    break;
                  case 1:
                    await _selectImageAndUploadHandler(
                      context,
                      ImageSource.gallery,
                    );
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
      );
    }
  }

  _selectImageAndUploadHandler(BuildContext context, ImageSource source) async {
    File? file = await _addImageService.imagePickerAndCropperHandler(
      context,
      source,
    );
    if (file == null) {
      return;
    }
    if (context.mounted) {
      isLoading = true;
      closeBottamModalHandler(context);
      profilePictureFile = file;
      ImageDetails prevProfilePhoto = _userProvider.user!.profilePhoto;
      final imageDetails = await uploadImageRepo.uploadImage(
        profilePictureFile,
        FirebaseConfig.profilePicturesFolderPath,
        fileName:
            "${_userProvider.user!.firebaseUser!}_${DateTime.now().millisecondsSinceEpoch}",
      );
      await updateProfilePhotoHandler(imageDetails);
      if (prevProfilePhoto.path != AppConstants.defaultProfilePhoto.path) {
        await uploadImageRepo.deleteImage(prevProfilePhoto.path);
      }
      isLoading = false;
    }
  }

  deleteProfilePhotoHandler(BuildContext context) {
    if (profilePictureFile.path == "") {
      return;
    }
    closeBottamModalHandler(context);
    late ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>
        banner;
    banner = Utils.showMaterialBanner(context, "Are you sure?",
        messageStyle: Theme.of(context).textTheme.titleSmall ??
            const TextStyle(fontSize: 14),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              banner.close(); // Close the dialog
              showProfilePictureOptionsBottomModel(context);
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              // Perform delete operation
              removeProfilePicture();
              banner.close(); // Close the dialog
            },
          ),
        ]);
  }

  removeProfilePicture() {
    profilePictureFile = File("");
  }

  editProfilePhotoHandler(BuildContext context) {
    closeBottamModalHandler(context);
    showImageSourceSelector(context);
  }

  closeBottamModalHandler(BuildContext context) {
    _navService.nav.pop();
  }

  profileMenuNavHandler(link) {
    try {
      _navService.nav.pushNamed(link);
    } catch (err) {
      // some error occured
    }
  }

  //************* account details page ****************** */
  String fullName = "";
  setFullName(val) {
    fullName = val;
  }

  bool isAnyAccountDetailsInputChanged = false;
  anyAccountDetailsInputChanged() {
    isAnyAccountDetailsInputChanged = true;
    notifyListeners();
  }

  resetAllAccountDetailsInput() {
    isAnyAccountDetailsInputChanged = false;
    notifyListeners();
  }

  isUpdateAccountDetailsCompleted() {
    isAnyAccountDetailsInputChanged = false;
    notifyListeners();
  }

  Future<void> saveButtonClickHandler(BuildContext context) async {
    try {
      isLoading = true;
      if (_userProvider.user != null) {
        List<String> parsedFullName = CustomUser.parseFullName(fullName);
        CustomUser updatedUser = CustomUser(
          phoneNumber: _userProvider.user!.phoneNumber,
          countryCode: _userProvider.user!.countryCode,
          email: _userProvider.user!.email,
          firebaseUser: _userProvider.user!.firebaseUser,
          firstName: parsedFullName[0],
          lastName: parsedFullName[1],
          profilePhoto: _userProvider.user!.profilePhoto,
        );
        await userRepo.updateGeneralUserDataInFirestore(updatedUser);

        _userProvider.setLoggedInUser(updatedUser);
        await _userProvider.saveLoggedInUserLocally();
      }
      isUpdateAccountDetailsCompleted();
      isLoading = false;
      if (context.mounted) {
        Utils.showSnackBar(context, "Updated Successfully");
      }
    } catch (err) {
      isLoading = false;
      Utils.showSnackBar(context, "Some error occured");
    }
  }

  Future<void> updateProfilePhotoHandler(ImageDetails imageDetails) async {
    try {
      isLoading = true;
      await userRepo.updateProfilePictureInFirestore(
        _userProvider.user!.firebaseUser!,
        imageDetails,
      );
      CustomUser updatedUser = CustomUser(
        phoneNumber: _userProvider.user!.phoneNumber,
        countryCode: _userProvider.user!.countryCode,
        email: _userProvider.user!.email,
        firebaseUser: _userProvider.user!.firebaseUser,
        firstName: _userProvider.user!.firstName,
        lastName: _userProvider.user!.lastName,
        profilePhoto: imageDetails,
      );
      _userProvider.setLoggedInUser(updatedUser);
      await _userProvider.saveLoggedInUserLocally();
      isLoading = false;
    } catch (err) {
      isLoading = false;
      rethrow;
    }
  }
}
