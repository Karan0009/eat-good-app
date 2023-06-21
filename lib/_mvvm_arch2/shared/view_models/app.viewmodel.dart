import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/locator.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/providers/theme_provider.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/providers/user_provider.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/routes/routes.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/services/navigation_service.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/utils/utils.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/view_models/loading.viewmodel.dart';

import '../../home_screen/models/home_page_view_arguments.dart';

class AppViewModel extends LoadingViewModel {
  final UserProvider _userProvider = locator<UserProvider>();
  final ThemeProvider _themeProvider = locator<ThemeProvider>();
  final NavigationService _navService = locator<NavigationService>();
  AppViewModel() : super();

  Future<void> initializeData(BuildContext context) async {
    try {
      final res = await _userProvider.setUserFromLocal();

      if (res) {
        _navService.nav.pushNamedAndRemoveUntil(
          NamedRoute.homeScreen,
          (route) => false,
          arguments: HomePageViewArguments(initalIndex: 0),
        );
      } else {
        _navService.nav.pushNamedAndRemoveUntil(
          NamedRoute.loginScreen,
          (route) => false,
        );
      }
    } catch (ex) {
      isLoading = false;
      Utils.showSnackBar(context, "Some error occured");
    }
  }

  ThemeData getTheme() {
    return _themeProvider.currentTheme;
  }
}
