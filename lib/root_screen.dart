import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram_clone_app/common/app_colors.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  List<BottomNavigationBarItem> get _buildBottomNavBarItems => [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home_rounded),
      label: 'home',
    ),
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
    const BottomNavigationBarItem(
      icon: Icon(Icons.add_box_sharp),
      label: 'add',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.videocam_outlined),
      activeIcon: Icon(Icons.videocam),
      label: 'reels',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline_outlined),
      activeIcon: Icon(Icons.person),
      label: 'profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: _buildBottomNavBarItems,
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        selectedItemColor: AppColors.primaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
      ),
    );
  }
}
