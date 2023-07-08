import 'package:flutter/material.dart';
import 'package:login_screen_2/login_screen/view_models/login_screen.viewmodel.dart';
import 'package:login_screen_2/shared/components/loading_overlay/loading_overlay.dart';
import 'package:login_screen_2/shared/services/app_localizations_service.dart';
import 'package:provider/provider.dart';

import '../../shared/components/custom_divider/custom_divider.dart';
import '../../shared/components/login_screen_footer/login_screen_footer.dart';
import '../components/phone_login_form/phone_login_form.dart';
import '../components/signup_with_google/signup_with_google.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  final phoneNumberFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height * 0.95;
    final vm = Provider.of<LoginViewModel>(context, listen: true);
    return LoadingOverlay(
      isLoading: vm.isLoading,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SizedBox(
                height: screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).translate("welcomeTo"),
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Text(
                            "Untitled",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          PhoneLoginForm(phoneNumberFormKey),
                          const SizedBox(
                            height: 20,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              const CustomDivider(
                                colors: [
                                  Color.fromRGBO(0, 0, 0, 0),
                                  Color.fromRGBO(0, 0, 0, 1),
                                  Color.fromRGBO(0, 0, 0, 0)
                                ],
                                thickness: 1,
                              ),
                              Container(
                                width: 30,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate("or"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SignupWithGoogleButtonWidget(),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => vm.skipSigninHandler(context),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate("skipSignIn"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
                      child: LoginScreenFooter(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
