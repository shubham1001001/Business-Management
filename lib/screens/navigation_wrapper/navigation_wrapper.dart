import 'package:flutter/material.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/screens/navigation_wrapper/tab_navigator.dart';

import '../Generate/generate_screen.dart';

class NavigationWrapper extends StatefulWidget {
  const NavigationWrapper({super.key});

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _currentIndex = 0;
  int selectinxe = 0;
  var tab = '';
  final Map<String, GlobalKey<NavigatorState>> navigatorKeys = {'Home': GlobalKey<NavigatorState>(), 'Report': GlobalKey<NavigatorState>(), 'Record': GlobalKey<NavigatorState>(), 'Generate': GlobalKey<NavigatorState>(), 'More': GlobalKey<NavigatorState>()};

  void _onTabTapped(int index) {
    const tabs = ['Home', 'Report', 'Generate', 'Record', 'More'];
    tab = tabs[index];
    if (index == 2) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (_) => const GenerateBottomSheet(),
      );
    } else if (_currentIndex == index) {
    } else {
      selectinxe = index;
      setState(() => _currentIndex = index);
      navigatorKeys[tab]?.currentState?.popUntil((r) => r.isFirst);
    }
  }

  void showGenerateBottomSheet(BuildContext context) {
    print("Genarate....");
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      isScrollControlled: true,
      builder: (_) => const GenerateBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          TabNavigator(tabName: 'Home', navigatorKey: navigatorKeys['Home']!),
          TabNavigator(tabName: 'Report', navigatorKey: navigatorKeys['Report']!),
          TabNavigator(tabName: 'Generate', navigatorKey: navigatorKeys['Generate']!),
          TabNavigator(tabName: 'Record', navigatorKey: navigatorKeys['Record']!),
          TabNavigator(tabName: 'More', navigatorKey: navigatorKeys['More']!),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.redcolor,
        unselectedItemColor: Colors.black87,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(tab == "Home" ? Icons.home : Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(tab == "Report" ? Icons.insert_chart : Icons.insert_chart_outlined), label: 'Report'),
          BottomNavigationBarItem(icon: Icon(tab == "Generate" ? Icons.add_circle : Icons.add_circle_outline), label: 'Generate'),
          BottomNavigationBarItem(icon: Icon(tab == "Record" ? Icons.dns_rounded : Icons.dns_outlined), label: 'Record'),
          BottomNavigationBarItem(icon: Icon(tab == "More" ? Icons.more : Icons.more_outlined), label: 'More'),
        ],
      ),
    );
  }
}
