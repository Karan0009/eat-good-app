import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../shared/components/loading_overlay/loading_overlay.dart';
import '../../../shared/services/app_localizations_service.dart';
import '../../profile_screen/view_models/profile.viewmodel.dart';

class ViewProfilePhotoScreen extends StatefulWidget {
  const ViewProfilePhotoScreen({super.key});

  @override
  State<ViewProfilePhotoScreen> createState() => _ViewProfilePhotoScreenState();
}

class _ViewProfilePhotoScreenState extends State<ViewProfilePhotoScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProfileScreenViewModel>(context, listen: true);

    return LoadingOverlay(
      isLoading: vm.isLoading,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).translate("profilePicture"),
            ),
            // leadingWidth: 100
            titleSpacing: -5,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            titleTextStyle: GoogleFonts.montserrat(
              textStyle: const TextStyle(fontSize: 20),
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                // height: screenHeight,
                margin: const EdgeInsets.all(20),
                child: SvgPicture.asset(
                  'assets/icons/arrow_back_icon.svg',
                  semanticsLabel: "back icon",
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  vm.showImageSourceSelector(context);
                },
                child: Container(
                  // height: screenHeight,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            // const Icon(
            //   Icons.arrow_back,
            //   color: Colors.black,
            // ),
          ),
          body: Image.file(vm.profilePicture),
        ),
      ),
    );
  }
}
