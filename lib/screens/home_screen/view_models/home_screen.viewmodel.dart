import 'package:login_screen_2/screens/home_screen/repositories/home_screen_repo.dart';

// import '../../locator.dart';
// import '../../shared/providers/user_provider.dart';
// import '../../shared/services/navigation_service.dart';
import '../../../shared/view_models/loading.viewmodel.dart';

class HomeViewModel extends LoadingViewModel {
  HomeViewModel({required this.homeRepo}) : super();

  final HomeScreenRepository homeRepo;
  // final UserProvider userProvider;

  // final UserProvider _userProvider = locator<UserProvider>();
  // final NavigationService _navService = locator<NavigationService>();
}
