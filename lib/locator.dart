import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:login_screen_2/screens/home_screen/repositories/home_screen_repo.dart';
import 'package:login_screen_2/screens/login_screen/repositories/login_screen_repo.dart';
import 'package:login_screen_2/screens/login_screen/repositories/login_screen_repo_impl.dart';
import 'package:login_screen_2/screens/profile_screen/repositories/profile_screen_repo.dart';
import 'package:login_screen_2/screens/profile_screen/repositories/profile_screen_repo_impl.dart';
import 'package:login_screen_2/shared/providers/theme_provider.dart';
// import 'package:login_screen_2/shared/providers/theme_provider.dart';
import 'package:login_screen_2/shared/providers/user_provider.dart';
import 'package:login_screen_2/shared/services/navigation_service.dart';

import 'screens/home_screen/repositories/home_screen_repo_impl.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerFactory<LoginScreenRepo>(() => LoginScreenRepoImpl());
  locator.registerFactory<ProfileScreenRepo>(() => ProfileScreenRepoImpl());
  locator
      .registerFactory<HomeScreenRepository>(() => HomeScreenRepositoryImpl());

  locator.registerSingleton<UserProvider>(UserProvider());
  locator.registerSingleton<ThemeProvider>(ThemeProvider());
}
