import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/svg_picture_widgets.dart';
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
            selectedItemColor: AppColors.redColor,
            unselectedItemColor: Colors.black87,
            onTap: (index) => tabProvider.changeTab(index, context, () => _showGenerateBottomSheet(context)),
            items: [
              BottomNavigationBarItem(
                icon: tab == "Home" ? SvgPictureWidgets(svgString: "assets/svg_icons/home_icon_fill.svg", color: AppColors.redColor) : SvgPictureWidgets(svgString: "assets/svg_icons/home_icon.svg", color: AppColors.appBlackColor),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: tab == "Report" ? SvgPictureWidgets(svgString: "assets/svg_icons/report_icon_fill.svg", color: AppColors.redColor) : SvgPictureWidgets(svgString: "assets/svg_icons/report_icon.svg", color: AppColors.appBlackColor),
                label: 'Report',
              ),
              BottomNavigationBarItem(
                icon: tab == "Generate" ? SvgPictureWidgets(svgString: "assets/svg_icons/generate_icon_fill.svg", color: AppColors.redColor) : SvgPictureWidgets(svgString: "assets/svg_icons/generate_icon.svg", color: AppColors.appBlackColor),
                label: 'Generate',
              ),
              BottomNavigationBarItem(
                icon: tab == "Record" ? SvgPictureWidgets(svgString: "assets/svg_icons/record_icon.svg", color: AppColors.redColor) : SvgPictureWidgets(svgString: "assets/svg_icons/record_icon_svg2.svg", color: AppColors.appBlackColor),
                label: 'Record',
              ),
              BottomNavigationBarItem(
                icon: tab == "More" ? SvgPictureWidgets(svgString: "assets/svg_icons/more_icon_fill.svg", color: AppColors.redColor) : SvgPictureWidgets(svgString: "assets/svg_icons/more_icon.svg", color: AppColors.appBlackColor),
                label: 'More',
              ),
            ],
          ),
        );
      },
    );
  }
}
