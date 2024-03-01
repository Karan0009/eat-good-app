// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:login_screen_2/screens/home_screen/view_models/home_screen.viewmodel.dart';
import 'package:provider/provider.dart';

import '../../home_landing_screen/views/home_landing_screen.view.dart';
import '../../../shared/layouts/screen_layout.dart';
import '../models/home_page_view_arguments.dart';

class HomeScreen extends StatefulWidget {
  final HomePageViewArguments data;
  const HomeScreen({required this.data, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBottomNavBarIndex = 0;
  final List<Widget> _widgetOptions = const [
    HomeLandingScreen(),
    HomeLandingScreen(),
    HomeLandingScreen(),
    HomeLandingScreen(),
  ];
  @override
  void initState() {
    super.initState();
    selectedBottomNavBarIndex = widget.data.initalIndex;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height * 0.95;
    final vm = Provider.of<HomeViewModel>(context, listen: true);

    return ScreenLayout(
      isLoading: vm.isLoading,
      screenHeight: screenHeight,
      bottomNavigationBar: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            unselectedIconTheme: const IconThemeData(
              color: Colors.red,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.redAccent,
            ),
            // backgroundColor: const Color(0x00ffffff),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
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
            selectedItemColor: Theme.of(context).primaryColor,
            onTap: (curIndex) {
              setState(() {
                selectedBottomNavBarIndex = curIndex;
              });
            },
          ),
          Positioned(
            top: -25,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  )),
              child: const Icon(
                Icons.flutter_dash_rounded,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      child: _widgetOptions[selectedBottomNavBarIndex],
    );
  }
}
