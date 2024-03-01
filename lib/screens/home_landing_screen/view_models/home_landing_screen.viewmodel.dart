import 'package:login_screen_2/screens/home_screen/repositories/home_screen_repo.dart';
import 'package:login_screen_2/shared/repositories/user_repo/user_repo.dart';
import 'package:login_screen_2/shared/routes/routes.dart';

import '../../../locator.dart';
// import '../../../shared/models/user_model.dart';
// import '../../../shared/providers/user_provider.dart';
import '../../../shared/services/navigation_service.dart';
import '../../../shared/view_models/loading.viewmodel.dart';

class HomeLandingViewModel extends LoadingViewModel {
  HomeLandingViewModel({
    required this.homeRepo,
    required this.userRepo,
  }) : super();

  final HomeScreenRepository homeRepo;
  final UserRepository userRepo;
  // final UserProvider _userProvider = locator<UserProvider>();

  // final UserProvider _userProvider = locator<UserProvider>();
  final NavigationService _navService = locator<NavigationService>();

  profileAvatarClickHandler() {
    _navService.nav
        .pushNamed(NamedRoute.profileScreen)
        .then((value) => isLoading = false);
  }
}
