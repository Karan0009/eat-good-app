import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen_2/_mvvm_arch2/profile_screen/view_models/profile.viewmodel.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/layouts/screen_layout.dart';
import 'package:provider/provider.dart';

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
    return ScreenLayout(
      isLoading: vm.isLoading,
      screenHeight: screenHeight,
      appBar: AppBar(
          title: const Text("Profile screen"),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          titleTextStyle: GoogleFonts.montserrat(
            textStyle: const TextStyle(fontSize: 20),
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      child: Column(
        children: [
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
