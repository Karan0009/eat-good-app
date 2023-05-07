import 'package:flutter/material.dart';
import 'package:login_screen_2/components/layouts/page_layout.dart';
import 'package:login_screen_2/providers/auth_provider.dart';
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
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return PageLayout(
      screenHeight: screenHeight,
      child: Column(
        children: [
          const Text("profile"),
          ElevatedButton(
              onPressed: () {
                auth.signOut().then(
                      (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                        "/login",
                        (route) => false,
                      ),
                    );
              },
              child: const Text("Sign out"))
        ],
      ),
    );
  }
}
