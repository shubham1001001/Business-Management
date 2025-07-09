import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.insert_chart_outlined), label: 'Report'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Generate'),
        BottomNavigationBarItem(icon: Icon(Icons.receipt_outlined), label: 'Record'),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded), label: 'More'),
      ],
    );
  }
}
