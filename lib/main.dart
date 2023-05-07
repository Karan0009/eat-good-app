import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_screen_2/providers/auth_provider.dart';
import 'package:login_screen_2/providers/user_provider.dart';
import 'package:login_screen_2/routes.dart';
import 'package:provider/provider.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(const MyApp());
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

    // Timer(const Duration(seconds: 3), () {
    //   FlutterNativeSplash.remove();
    // });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Consumer(builder: (context, AuthProvider auth, _) {
        switch (auth.authStatus) {
          case AuthStatus.authenticated:
            {
              FlutterNativeSplash.remove();
              return MaterialApp(
                title: 'My App',
                debugShowCheckedModeBanner: false,
                initialRoute: "/home",
                routes: routes,
              );
            }
          case AuthStatus.unauthenticated:
            {
              FlutterNativeSplash.remove();
              return MaterialApp(
                title: 'My App',
                debugShowCheckedModeBanner: false,
                initialRoute: "/login",
                routes: routes,
              );
            }
          default:
            return const CircularProgressIndicator();
        }
      }),
    );
  }
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
