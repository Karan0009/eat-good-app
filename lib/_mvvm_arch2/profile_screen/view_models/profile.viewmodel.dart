import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/profile_screen/repositories/profile_screen_repo.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/routes/routes.dart';

import '../../locator.dart';
import '../../shared/providers/user_provider.dart';
import '../../shared/services/navigation_service.dart';
import '../../shared/utils/utils.dart';
import '../../shared/view_models/loading.viewmodel.dart';

class ProfileScreenViewModel extends LoadingViewModel {
  ProfileScreenViewModel({required this.profileRepo}) : super();

  final ProfileScreenRepo profileRepo;
  final UserProvider _userProvider = locator<UserProvider>();
  final NavigationService _navService = locator<NavigationService>();

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
}
