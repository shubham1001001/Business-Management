import 'package:flutter/material.dart';
import 'package:sales/screens/home_screen/widgets/quick_link_widgets.dart';

import '../../../routes/app_routes_name.dart';

class QuickLinkScrollView extends StatelessWidget {
  const QuickLinkScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final isLandscape = screenWidth > screenHeight;
    final items = [
      {'label': 'Sale order', 'icon': "assets/icons/Sales var.png"},
      {'label': 'Item', 'icon': "assets/icons/q1.png"},
      {'label': 'Day book', 'icon': "assets/icons/q2.png"},
      {'label': 'Customer', 'icon': "assets/icons/q3.png"},
      {'label': 'Rent', 'icon': "assets/icons/q4.png"},
      {'label': 'Trip', 'icon': "assets/icons/q5.png"},
    ];

    // Group into columns with 2 items each
    List<List<Map<String, String>>> columns = [];
    for (int i = 0; i < items.length; i += 2) {
      columns.add([items[i], if (i + 1 < items.length) items[i + 1]]);
    }

    return SizedBox(
      height: isLandscape ? size.height * 0.85 : size.height * 0.35,

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Row(
          children: columns.map((columnItems) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: columnItems.map((item) {
                  return GestureDetector(
                    onTap: () {
                      final label = item['label'];
                      if (label == 'Item') {
                        Navigator.of(context).pushNamed(AppRoutesName.itemListScreen);
                      } else if (label == 'Trip') {
                        Navigator.of(context).pushNamed(AppRoutesName.tripSummaryScreen);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: QuickLink(icon: item['icon'].toString(), label: item['label'].toString()),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
