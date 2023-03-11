import 'package:flutter/material.dart';
import 'package:login_screen_2/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.grey,
      ),
      home: const LoginScreen(),
    );
  }
}
