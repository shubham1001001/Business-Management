import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/screens/navigation_wrapper/tab_navigator.dart';

import '../../providers/tab_provider/tab_provider.dart';
import '../Generate/generate_screen.dart';

class NavigationWrapper extends StatelessWidget {
  NavigationWrapper({super.key});

  final Map<String, GlobalKey<NavigatorState>> navigatorKeys = {'Home': GlobalKey<NavigatorState>(), 'Report': GlobalKey<NavigatorState>(), 'Record': GlobalKey<NavigatorState>(), 'Generate': GlobalKey<NavigatorState>(), 'More': GlobalKey<NavigatorState>()};

  void _showGenerateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => GenerateBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(
      builder: (context, tabProvider, _) {
        final currentIndex = tabProvider.currentIndex;
        final tab = tabProvider.currentTab;

        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: [
              TabNavigator(tabName: 'Home', navigatorKey: navigatorKeys['Home']!),
              TabNavigator(tabName: 'Report', navigatorKey: navigatorKeys['Report']!),
              TabNavigator(tabName: 'Generate', navigatorKey: navigatorKeys['Generate']!),
              TabNavigator(tabName: 'Record', navigatorKey: navigatorKeys['Record']!),
              TabNavigator(tabName: 'More', navigatorKey: navigatorKeys['More']!),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black87,
            onTap: (index) => tabProvider.changeTab(index, context, () => _showGenerateBottomSheet(context)),
            items: [
              BottomNavigationBarItem(icon: Icon(tab == "Home" ? Icons.home : Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(tab == "Report" ? Icons.insert_chart : Icons.insert_chart_outlined), label: 'Report'),
              BottomNavigationBarItem(icon: Icon(tab == "Generate" ? Icons.add_circle : Icons.add_circle_outline), label: 'Generate'),
              BottomNavigationBarItem(icon: Icon(tab == "Record" ? Icons.dns_rounded : Icons.dns_outlined), label: 'Record'),
              BottomNavigationBarItem(icon: Icon(tab == "More" ? Icons.more : Icons.more_outlined), label: 'More'),
            ],
          ),
        );
      },
    );
  }
}
