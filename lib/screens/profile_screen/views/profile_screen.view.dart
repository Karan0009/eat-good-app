import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen_2/screens/profile_screen/view_models/profile.viewmodel.dart';
import 'package:login_screen_2/shared/services/app_localizations_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

import '../../../locator.dart';
import '../../../shared/components/loading_overlay/loading_overlay.dart';
import '../../../shared/components/margin/margin.dart';
import '../../../shared/providers/user_provider.dart';
import '../components/avatar_circle/avatar_circle.dart';
import '../components/menu_item/menu_item.dart';

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

    return LoadingOverlay(
      isLoading: vm.isLoading,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
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
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            leading: GestureDetector(
              onTap: () {
                vm.back();
              },
              child: Container(
                // height: screenHeight,
                margin: const EdgeInsets.all(20),
                child: SvgPicture.asset(
                  'assets/icons/arrow_back_icon.svg',
                  semanticsLabel: "back icon",
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
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
            // const Icon(
            //   Icons.arrow_back,
            //   color: Colors.black,
            // ),
          ),
          body:
              // SingleChildScrollView(
              //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              //   child:
              Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset(
                "assets/images/profile_cover_illustration.png",
                height: screenHeight * 0.2,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  const Margin(height: 100),
                  const AvatarCircle(),
                  // SizedBox(
                  //   height: 400,
                  //   // padding: const EdgeInsets.symmetric(horizontal: 30),
                  //   child:
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.95,
                      ),
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        bottom: 30,
                      ),
                      itemCount: vm
                          .getMenuItems()
                          .length, // Total number of items in the grid
                      itemBuilder: (BuildContext context, int index) {
                        return MenuItem(
                          svgPath: vm.getMenuItems()[index].icon,
                          title: AppLocalizations.of(context)
                              .translate(vm.getMenuItems()[index].title),
                        );
                      },
                    ),
                  ),
                  // ),
                ],
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}
