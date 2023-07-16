import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:login_screen_2/screens/home_screen/repositories/home_screen_repo.dart';
import 'package:login_screen_2/screens/login_screen/repositories/login_screen_repo.dart';
import 'package:login_screen_2/screens/login_screen/repositories/login_screen_repo_impl.dart';
import 'package:login_screen_2/screens/profile_screen/repositories/profile_screen_repo.dart';
import 'package:login_screen_2/screens/profile_screen/repositories/profile_screen_repo_impl.dart';
import 'package:login_screen_2/shared/providers/theme_provider.dart';
// import 'package:login_screen_2/shared/providers/theme_provider.dart';
import 'package:login_screen_2/shared/providers/user_provider.dart';
import 'package:login_screen_2/shared/repositories/auth_repo/auth_repo.dart';
import 'package:login_screen_2/shared/repositories/auth_repo/auth_repo_impl.dart';
import 'package:login_screen_2/shared/repositories/upload_image_repo/upload_image_repo.dart';
import 'package:login_screen_2/shared/repositories/upload_image_repo/upload_image_repo_impl.dart';
import 'package:login_screen_2/shared/repositories/user_repo/user_repo.dart';
import 'package:login_screen_2/shared/repositories/user_repo/user_repo_impl.dart';
import 'package:login_screen_2/shared/services/add_image_service.dart';
import 'package:login_screen_2/shared/services/navigation_service.dart';

import 'screens/home_screen/repositories/home_screen_repo_impl.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  locator
      .registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerLazySingleton<AddImageService>(() => AddImageService());
  locator.registerFactory<LoginScreenRepo>(() => LoginScreenRepoImpl());
  locator.registerFactory<ProfileScreenRepo>(() => ProfileScreenRepoImpl());
  locator
      .registerFactory<HomeScreenRepository>(() => HomeScreenRepositoryImpl());
  locator.registerFactory<UploadImageRepo>(() => UploadImageRepoImpl());
  locator.registerFactory<UserRepository>(() => UserRepositoryImpl());
  locator.registerFactory<AuthRepo>(() => AuthRepoImpl());

  locator.registerSingleton<UserProvider>(UserProvider());
  locator.registerSingleton<ThemeProvider>(ThemeProvider());
}
