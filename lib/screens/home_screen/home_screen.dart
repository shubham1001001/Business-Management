import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/screens/home_screen/widgets/dashboard_content.dart';
import 'package:sales/screens/home_screen/widgets/support_content.dart';

import '../../core/constants/spacing.dart';
import '../../core/widgets/text_scale_widgets.dart';
import '../../providers/home_provider/home_tab_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.watch<TabProviderHome>().selectedTab;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("L company name", style: TextStyle(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 75))),
        actions: [const Icon(Icons.notifications_none), AppSpacing.mediumWidth16],
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            Row(children: [buildTab(context, 0, "Dashboard"), AppSpacing.largeHeight, buildTab(context, 1, "Support")]),
            SizedBox(height: size.height * 0.017),

            /// Use Expanded to contain scrollable content
            Expanded(child: selectedTab == 0 ? DashboardContent() : const SupportContent()),
          ],
        ),
      ),
    );
  }

  Widget buildTab(BuildContext context, int index, String label) {
    final size = MediaQuery.of(context).size;
    final isSelected = context.watch<TabProviderHome>().selectedTab == index;
    return GestureDetector(
      onTap: () => context.read<TabProviderHome>().changeTab(index),
      child: Column(
        children: [
          Row(
            children: [
              Icon(index == 0 ? Icons.dashboard_outlined : Icons.support, size: 18),
              const SizedBox(width: 4),
              Text(label, style: isSelected ? AppTextStyles.title16 : AppTextStyles.textSize16),
            ],
          ),
          const SizedBox(height: 4),
          Container(height: 2, width: size.width * 0.3, color: isSelected ? AppColors.redColor : Colors.transparent),
        ],
      ),
    );
  }
}
