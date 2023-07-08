import 'package:login_screen_2/home_screen/repositories/home_screen_repo.dart';
import 'package:login_screen_2/shared/routes/routes.dart';

import '../../locator.dart';
import '../../shared/services/navigation_service.dart';
import '../../shared/view_models/loading.viewmodel.dart';

class HomeLandingViewModel extends LoadingViewModel {
  HomeLandingViewModel({required this.homeRepo}) : super();

  final HomeScreenRepository homeRepo;
  // final UserProvider userProvider;

  // final UserProvider _userProvider = locator<UserProvider>();
  final NavigationService _navService = locator<NavigationService>();

  profileAvatarClickHandler() {
    _navService.nav.pushNamed(NamedRoute.profileScreen);
  }
}
