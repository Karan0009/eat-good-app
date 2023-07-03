import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen_2/_mvvm_arch2/profile_screen/view_models/profile.viewmodel.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/layouts/screen_layout.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/services/app_localizations_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

import '../../locator.dart';
import '../../shared/providers/user_provider.dart';

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
    final userProvider = locator<UserProvider>();
    double screenHeight = MediaQuery.of(context).size.height * 0.95;
    final vm = Provider.of<ProfileScreenViewModel>(context, listen: true);
    return ScreenLayout(
      isLoading: vm.isLoading,
      screenHeight: screenHeight,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("yourAccount"),
        ),
        // leadingWidth: 100
        titleSpacing: -5,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: GoogleFonts.montserrat(
          textStyle: const TextStyle(fontSize: 20),
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        ),
        leading: Container(
          margin: const EdgeInsets.all(20),
          child: SvgPicture.asset(
            'assets/icons/arrow_back_icon.svg',
            semanticsLabel: "back icon",
            color: Colors.black,
          ),
        ),
        // const Icon(
        //   Icons.arrow_back,
        //   color: Colors.black,
        // ),
      ),
      child: Column(
        children: [
          if (userProvider.user != null)
            ElevatedButton(
              onPressed: () {
                vm.logoutButtonClickHandler(context);
              },
              child: const Text("Logout"),
            ),
          if (userProvider.user == null)
            ElevatedButton(
              onPressed: () {
                vm.loginButtonClickHandler(context);
              },
              child: const Text("Login"),
            ),
        ],
      ),
    );
  }
}
