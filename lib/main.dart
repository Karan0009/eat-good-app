import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/locator.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/repositories/login_screen_repo.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/view_models/login_screen.viewmodel.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/views/login_screen.view.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/routes/routes.dart';
import 'package:provider/provider.dart';

import '_mvvm_arch2/shared/services/navigation_service.dart';

void main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(loginRepo: locator<LoginScreenRepo>()),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      FlutterNativeSplash.remove();
    });
  }

  final navigatorService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
    );
  }

  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (_) => AuthProvider(),
  //     child: Consumer(builder: (context, AuthProvider auth, _) {
  //       switch (auth.authStatus) {
  //         case AuthStatus.authenticated:
  //           {
  //             FlutterNativeSplash.remove();
  //             return MaterialApp(
  //               title: 'My App',
  //               debugShowCheckedModeBanner: false,
  //               initialRoute: "/home",
  //               routes: routes,
  //             );
  //           }
  //         case AuthStatus.unauthenticated:
  //           {
  //             FlutterNativeSplash.remove();
  //             return MaterialApp(
  //               title: 'My App',
  //               debugShowCheckedModeBanner: false,
  //               initialRoute: "/login",
  //               routes: routes,
  //             );
  //           }
  //         default:
  //           return const CircularProgressIndicator();
  //       }
  //     }),
  //   );
  // }
}

// return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//         ChangeNotifierProvider(create: (_) => UserProvider()),
//       ],
//       child:
// Consumer(builder: (context, AuthProvider auth, _) {
//         if (auth.isSignedIn) {
//           FlutterNativeSplash.remove();
//           return MaterialApp(
//             title: 'My App',
//             debugShowCheckedModeBanner: false,
//             initialRoute: "/home",
//             routes: routes,
//           );
//         } else {
//           FlutterNativeSplash.remove();
//           return MaterialApp(
//             title: 'My App',
//             debugShowCheckedModeBanner: false,
//             initialRoute: "/login",
//             routes: routes,
//           );
//         }
//       }),

// class MyAppInner extends StatelessWidget {
//   const MyAppInner({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthProvider>(context, listen: false);
//     return MaterialApp(
//       title: 'My App',
//       debugShowCheckedModeBanner: false,
//       initialRoute: auth.isSignedIn ? "/home" : "/login",
//       routes: routes,
//     );
//   }
// }
