import 'package:flutter/material.dart';

import '../_mvvm_arch2/locator.dart';
import '../_mvvm_arch2/shared/layouts/page_layout.dart';
import '../_mvvm_arch2/shared/providers/user_provider.dart';
// import 'package:provider/provider.dart';

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
    final userProvider = locator<UserProvider>();
    double screenHeight = MediaQuery.of(context).size.height * 0.95;
    // final auth = Provider.of<AuthProvider>(context, listen: true);
    return PageLayout(
      screenHeight: screenHeight,
      child: Column(
        children: [
          const Text("home screen"),
          Text(userProvider.user?.firstName ?? ""),
          Text(userProvider.user?.lastName ?? ""),
          Text(userProvider.user?.phoneNumber ?? "")
        ],
      ),
    );
  }
}
