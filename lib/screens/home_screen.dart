// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:login_screen_2/screens/home_screen_home_nav.dart';
import 'package:login_screen_2/screens/home_screen_profile_nav.dart';
import 'package:provider/provider.dart';

import '../components/layouts/screen_layout.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  final int initalIndex;
  const HomeScreen({required this.initalIndex, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBottomNavBarIndex = 0;
  final List<Widget> _widgetOptions = const [
    HomeNavHomeScreen(),
    ProfileScreen()
  ];
  @override
  void initState() {
    super.initState();
    selectedBottomNavBarIndex = widget.initalIndex;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height * 0.95;
    final auth = Provider.of<AuthProvider>(context, listen: true);
    return ScreenLayout(
      isLoading: auth.isLoading,
      screenHeight: screenHeight,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedBottomNavBarIndex,
        selectedItemColor: Colors.blue,
        onTap: (curIndex) {
          setState(() {
            selectedBottomNavBarIndex = curIndex;
          });
        },
      ),
      child: _widgetOptions[selectedBottomNavBarIndex],
    );
  }
}
