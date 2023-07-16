import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_screen_2/screens/profile_screen/view_models/profile.viewmodel.dart';
import 'package:login_screen_2/shared/components/custom_elevated_button/custom_elevated_button.dart';
import 'package:login_screen_2/shared/layouts/screen_layout.dart';
import 'package:login_screen_2/shared/services/app_localizations_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

import '../../../locator.dart';
import '../../../shared/components/avatar_circle/avatar_circle.dart';
import '../../../shared/components/custom_input/custom_input.dart';
import '../../../shared/components/margin/margin.dart';
import '../../../shared/providers/user_provider.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  int selectedBottomNavBarIndex = 0;
  @override
  void initState() {
    super.initState();
    selectedBottomNavBarIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height * 0.95;
    final userProvider = locator<UserProvider>();
    final vm = Provider.of<ProfileScreenViewModel>(context, listen: true);

    return ScreenLayout(
      isLoading: vm.isLoading,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("profileDetails"),
        ),
        // leadingWidth: 100
        titleSpacing: -5,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: GoogleFonts.montserrat(
          textStyle: const TextStyle(fontSize: 20),
          color: const Color.fromRGBO(52, 64, 84, 1),
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
              color: const Color.fromRGBO(52, 64, 84, 1),
            ),
          ),
        ),
      ),
      screenHeight: screenHeight,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Margin(height: 10),
            const AvatarCircle(),
            const Margin(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  CustomInput(
                    label: "FULL NAME",
                    onChangeHandler: (val) {
                      vm.anyAccountDetailsInputChanged();
                      vm.setFullName(val);
                    },
                    placeholder: "Full Name",
                    value: userProvider.user?.getFullName() ?? "",
                  ),
                  const Margin(height: 20),
                  CustomInput(
                    label: "EMAIL",
                    onChangeHandler: (val) {},
                    placeholder: "Email",
                    value: userProvider.user?.email ?? "",
                    enabled: false,
                  ),
                  const Margin(height: 20),
                  CustomInput(
                    label: "PHONE NUMBER",
                    onChangeHandler: (val) {},
                    placeholder: "Phone Number",
                    value: userProvider.user?.phoneNumber ?? "",
                    enabled: false,
                  ),
                  const Margin(height: 20),
                  CustomElevatedButton(
                    disabled: !vm.isAnyAccountDetailsInputChanged,
                    onPressed: () {
                      vm.saveButtonClickHandler(context);
                    },
                    icon: const Icon(
                      Icons.save_rounded,
                      color: Color.fromRGBO(214, 248, 184, 1),
                    ),
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Text(
                      "Save",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 16,
                            color: const Color.fromRGBO(214, 248, 184, 1),
                          ),
                    ),
                  ),
                  const Margin(height: 20),
                  CustomElevatedButton(
                    onPressed: () {
                      vm.logoutButtonClickHandler(context);
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Color.fromRGBO(240, 68, 56, 1),
                    ),
                    style: null,
                    child: Text(
                      "Log Out",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 16,
                            color: const Color.fromRGBO(0, 0, 0, 1),
                          ),
                    ),
                  ),
                  const Margin(height: 10),
                  Text(
                    "You can always log back in with your phone number.",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: const Color.fromRGBO(152, 162, 179, 1),
                    ),
                  )
                ],
              ),
            ),

            // SizedBox(
            //   height: 400,
            //   // padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child:
            // Expanded(
            //   child: GridView.builder(
            //     gridDelegate:
            //         const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2, // Number of columns in the grid
            //       crossAxisSpacing: 10,
            //       mainAxisSpacing: 10,
            //       childAspectRatio: 0.95,
            //     ),
            //     padding: const EdgeInsets.only(
            //       left: 30,
            //       right: 30,
            //       bottom: 30,
            //     ),
            //     itemCount: vm
            //         .getMenuItems()
            //         .length, // Total number of items in the grid
            //     itemBuilder: (BuildContext context, int index) {
            //       return MenuItem(
            //         svgPath: vm.getMenuItems()[index].icon,
            //         title: AppLocalizations.of(context)
            //             .translate(vm.getMenuItems()[index].title),
            //       );
            //     },
            //   ),
            // ),
            // ),
          ],
        ),
      ),
    );
  }
}
