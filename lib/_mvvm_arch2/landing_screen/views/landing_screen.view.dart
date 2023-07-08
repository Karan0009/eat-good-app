import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:login_screen_2/_mvvm_arch2/login_screen/view_models/login_screen.viewmodel.dart';
import 'package:login_screen_2/_mvvm_arch2/shared/components/loading_overlay/loading_overlay.dart';

import 'package:provider/provider.dart';

import '../../shared/view_models/app.viewmodel.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    final appVm = Provider.of<AppViewModel>(context, listen: false);
    appVm.initializeData(context).then((value) {
      FlutterNativeSplash.remove();
    }).catchError((err) {
      // some error occured
    });
    // Provider.of<LoginViewModel>(context,listen: false).
  }

  final phoneNumberFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context, listen: true);
    return LoadingOverlay(
      isLoading: vm.isLoading,
      child: const Text("Loading app..."),
    );
  }
}
