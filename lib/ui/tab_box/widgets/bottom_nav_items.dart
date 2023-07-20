import 'package:flutter/cupertino.dart';

BottomNavigationBarItem getBottomNavItem({
  required Widget icon,
  required String label,
}) {
  return BottomNavigationBarItem(
      icon: icon,
      label: label,
  );
}