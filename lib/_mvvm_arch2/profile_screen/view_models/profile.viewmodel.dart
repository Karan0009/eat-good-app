import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/profile_screen/repositories/profile_screen_repo.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/routes/routes.dart';

import '../../locator.dart';
import '../../shared/providers/user_provider.dart';
import '../../shared/services/navigation_service.dart';
import '../../shared/utils/utils.dart';
import '../../shared/view_models/loading.viewmodel.dart';
import '../models/menu_item_model.dart';

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
}
