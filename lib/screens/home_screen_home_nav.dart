import 'package:flutter/material.dart';
import 'package:login_screen_2/components/layouts/page_layout.dart';
import 'package:login_screen_2/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeNavHomeScreen extends StatefulWidget {
  const HomeNavHomeScreen({super.key});

  @override
  State<HomeNavHomeScreen> createState() => _HomeNavHomeScreenState();
}

class _HomeNavHomeScreenState extends State<HomeNavHomeScreen> {
  int selectedBottomNavBarIndex = 0;
  @override
  void initState() {
    super.initState();
    selectedBottomNavBarIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height * 0.95;
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return PageLayout(
      screenHeight: screenHeight,
      child: Column(
        children: const [Text("home screen")],
      ),
    );
  }
}
