import 'package:flutter/material.dart';
import 'package:login_screen_2/locator.dart';
import 'package:login_screen_2/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../screens/profile_screen/view_models/profile.viewmodel.dart';

class AvatarCircle extends StatelessWidget {
  const AvatarCircle({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.3;
    final vm = Provider.of<ProfileScreenViewModel>(context, listen: true);
    final userProvider = locator<UserProvider>();

    return GestureDetector(
      onTap: () {
        vm.showProfilePictureOptionsBottomModel(context);
      },
      child: SizedBox(
        height: width + 20,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(214, 248, 184, 1),
                borderRadius: BorderRadius.circular(width),
                image: userProvider.user?.profilePhoto != null ||
                        userProvider.user?.profilePhoto != ''
                    ? DecorationImage(
                        image: NetworkImage(
                          userProvider.user!.profilePhoto!,
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      )
                    : const DecorationImage(
                        image: AssetImage(
                          "assets/images/profile_cover_illustration.png",
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                border: Border.all(
                  color: Colors.white,
                  width: 6,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 6,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: const Color.fromRGBO(104, 172, 108, 1),
                  child: Icon(
                    userProvider.user?.profilePhoto != null ||
                            userProvider.user?.profilePhoto != ''
                        ? Icons.edit_rounded
                        : Icons.add_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              // Container(
              //   width: 45,
              //   height: 45,
              //   decoration: Circle(
              //     color: const Color.fromRGBO(104, 172, 108, 1),
              //     shape: BoxShape.circle,
              //     // borderRadius: BorderRadius.circular(45),
              //     border: Border.all(
              //       color: Colors.white,
              //       width: 6,
              //     ),
              //   ),
              //   child: const Icon(
              //     Icons.add_rounded,
              //     color: Colors.white,
              //     size: 30,
              //   ),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
