import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen_2/_mvvm_arch2/home_landing_screen/view_models/home_landing_screen.viewmodel.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../../shared/providers/user_provider.dart';

class HomeLandingScreen extends StatefulWidget {
  const HomeLandingScreen({super.key});

  @override
  State<HomeLandingScreen> createState() => _HomeLandingScreenState();
}

class _HomeLandingScreenState extends State<HomeLandingScreen> {
  int selectedBottomNavBarIndex = 0;
  @override
  void initState() {
    super.initState();
    selectedBottomNavBarIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = locator<UserProvider>();
    final vm = Provider.of<HomeLandingViewModel>(context, listen: true);
    // final auth = Provider.of<AuthProvider>(context, listen: true);
    // return PageLayout(
    //   screenHeight: screenHeight,
    //   child: Column(
    //     children: [
    //       const Text("hello world"),
    //       const Text("home screen"),
    //       Text(userProvider.user?.firstName ?? ""),
    //       Text(userProvider.user?.lastName ?? ""),
    //       Text(userProvider.user?.phoneNumber ?? "")
    //     ],
    //   ),
    // );

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Ahoy ${userProvider.user?.firstName} 👋"),
          // leadingWidth: 100
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          titleTextStyle: GoogleFonts.montserrat(
            textStyle: const TextStyle(fontSize: 20),
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  vm.profileAvatarClickHandler();
                },
                child: CircleAvatar(
                  child: Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                ))
          ],
          // leading: Container(
          //   // height: screenHeight,
          //   margin: const EdgeInsets.all(20),
          //   child: SvgPicture.asset(
          //     'assets/icons/arrow_back_icon.svg',
          //     semanticsLabel: "back icon",
          //     color: Colors.white,
          //   ),
          // ),
        ),
        body: Column(
          children: [
            const Text("hello world"),
            const Text("home screen"),
            Text(userProvider.user?.firstName ?? ""),
            Text(userProvider.user?.lastName ?? ""),
            Text(userProvider.user?.phoneNumber ?? "")
          ],
        ),
      ),
    );
  }
}
