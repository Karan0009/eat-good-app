import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/profile_screen/view_models/profile.viewmodel.dart';
import 'package:provider/provider.dart';

import '../../shared/layouts/page_layout.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedBottomNavBarIndex = 0;
  @override
  void initState() {
    super.initState();
    selectedBottomNavBarIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height * 0.95;
    final vm = Provider.of<ProfileScreenViewModel>(context, listen: true);
    return PageLayout(
      screenHeight: screenHeight,
      child: Column(
        children: [
          const Text("profile"),
          ElevatedButton(
            onPressed: () {
              vm.logoutButtonClickHandler(context);
            },
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }
}
