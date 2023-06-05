// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:login_screen_2/_mvvm_arch2/home_screen/view_models/home_screen.viewmodel.dart';
import 'package:login_screen_2/screens/home_screen_home_nav.dart';
import 'package:login_screen_2/screens/home_screen_profile_nav.dart';
import 'package:provider/provider.dart';

import '../../shared/layouts/screen_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBottomNavBarIndex = 0;
  dynamic arguments;
  final List<Widget> _widgetOptions = const [
    HomeNavHomeScreen(),
    ProfileScreen()
  ];
  @override
  void initState() {
    super.initState();
    arguments = ModalRoute.of(context)?.settings.arguments;
    selectedBottomNavBarIndex = arguments.initalIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height * 0.95;
    final vm = Provider.of<HomeViewModel>(context, listen: true);
    return ScreenLayout(
      isLoading: vm.isLoading,
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
