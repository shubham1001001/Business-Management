import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/screens/home_screen/widgets/dashboard_content.dart';
import 'package:sales/screens/home_screen/widgets/support_content.dart';

import '../../providers/home_provider/home_tabprovider.dart';

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
    final selectedTab = context.watch<TabProvider>().selectedTab;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("L company name"), actions: const [Icon(Icons.notifications_none), SizedBox(width: 16)], elevation: 0, backgroundColor: AppColors.backgroundColor, foregroundColor: Colors.black),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            Row(children: [buildTab(context, 0, "Dashboard"), const SizedBox(width: 20), buildTab(context, 1, "Support")]),
            SizedBox(height: size.height * 0.017),

            /// Use Expanded to contain scrollable content
            Expanded(child: selectedTab == 0 ? const DashboardContent() : const SupportContent()),
          ],
        ),
      ),
    );
  }

  Widget buildTab(BuildContext context, int index, String label) {
    final size = MediaQuery.of(context).size;
    final isSelected = context.watch<TabProvider>().selectedTab == index;
    return GestureDetector(
      onTap: () => context.read<TabProvider>().changeTab(index),
      child: Column(
        children: [
          Row(
            children: [
              Icon(index == 0 ? Icons.dashboard_outlined : Icons.support, size: 18),
              const SizedBox(width: 4),
              Text(label, style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
          const SizedBox(height: 4),
          Container(height: 2, width: size.width * 0.3, color: isSelected ? AppColors.redcolor : Colors.transparent),
        ],
      ),
    );
  }
}
