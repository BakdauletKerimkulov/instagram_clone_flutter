import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _iconSize = 24.0;

final bottomNavBarItems = [
  _item(
    icon: 'assets/icons/instagram_home_feed_icon.svg',
    label: 'Home',
    activeIcon: 'assets/icons/instagram_home_filled.svg',
  ),
  _item(icon: 'assets/icons/instagram-search-icon.svg', label: 'Search'),
  _item(icon: 'assets/icons/instagram_add_new_post_icon.svg', label: 'Create'),
  _item(
    icon: 'assets/icons/instagram-reels-icon.svg',
    label: 'Reels',
    activeIcon: 'assets/icons/instagram_reels_icon_full.svg',
  ),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
];

BottomNavigationBarItem _item({
  required String icon,
  required String label,
  String? activeIcon,
}) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(icon, height: _iconSize, width: _iconSize),
    label: label,
    activeIcon: activeIcon != null
        ? SvgPicture.asset(activeIcon, height: _iconSize, width: _iconSize)
        : null,
  );
}
