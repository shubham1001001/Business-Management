import 'package:flutter/material.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/screens/Generate/widgets/cart_widgets.dart';

import '../../routes/app_routes_name.dart';

class GenerateBottomSheet extends StatelessWidget {
  GenerateBottomSheet({super.key});
  final items = [
    {'label': 'Item', 'icon': "assets/icons/g1.png"},
    {'label': 'Account', 'icon': "assets/icons/g2.png"},
    {'label': 'Vehicle', 'icon': "assets/icons/g3.png"},
    {'label': 'Unit', 'icon': "assets/icons/g04.png"},
    {'label': 'Vendor', 'icon': "assets/icons/g5.png"}, //
    {'label': 'Customer', 'icon': "assets/icons/g6.png"},
    {'label': 'Warehouse', 'icon': "assets/icons/g7.png"},
    {'label': 'Point', 'icon': "assets/icons/g8.png"},
    {'label': 'Alert', 'icon': "assets/icons/g9.png"},
    {'label': 'Staff', 'icon': "assets/icons/g10.png"},
    // Add more if needed
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    List<List<Map<String, String>>> pages = [];
    for (int i = 0; i < items.length; i += 10) {
      pages.add(items.sublist(i, (i + 10 > items.length) ? items.length : i + 10));
    }

    final PageController controller = PageController();
    final ValueNotifier<int> currentPage = ValueNotifier<int>(0);

    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(AppSpacing.allPadding16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(children: [Text("Generate", style: AppTextStyles.title)]),
          SizedBox(height: size.height * 0.015),

          // PageView with 2-row layout
          SizedBox(
            height: size.height * 0.35,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: controller,
              itemCount: pages.length,
              onPageChanged: (index) => currentPage.value = index,
              itemBuilder: (context, pageIndex) {
                final pageItems = pages[pageIndex];
                int crossAxisCount = 5;
                double childAspectRatio = 0.9;

                if (screenWidth >= 600 && screenWidth < 900) {
                  // Tablet (portrait)
                  crossAxisCount = 5;
                  childAspectRatio = 1.5;
                } else if (screenWidth >= 900) {
                  // Tablet (landscape) or larger
                  crossAxisCount = 5;
                  childAspectRatio = 1.6;
                }
                return GridView.count(
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 5,
                  childAspectRatio: childAspectRatio, //isLandscape ? 1.5 : 0.7,
                  crossAxisCount: crossAxisCount,
                  physics: NeverScrollableScrollPhysics(),
                  children: pageItems.map((item) {
                    return GestureDetector(
                      onTap: () {
                        // context.read<GenerateProvider>().select(item['label'].toString(), context);

                        if (item['label'].toString() == 'Vendor') {
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed(AppRoutesName.venderListScreen);
                        }
                        if (item['label'].toString() == 'Staff') {
                          Navigator.pop(context);
                          Navigator.of(context).pushNamed(AppRoutesName.addStaffScreen);
                        }
                        if (item['label'].toString() == 'Vehicle') {
                          // Navigator.pop(context);
                          Navigator.of(context).pushNamed(AppRoutesName.vehicleOverviewScreen);
                        }
                        if (item['label'].toString() == 'Account') {
                          // Navigator.pop(context);
                          Navigator.of(context).pushNamed(AppRoutesName.accountSummaryScreen);
                        }
                      },
                      child: GenerateCart(icon: item['icon'].toString(), label: item['label'].toString()),
                    );
                  }).toList(),
                );
              },
            ),
          ),

          SizedBox(height: size.height * 0.015),

          // Page indicators
          ValueListenableBuilder<int>(
            valueListenable: currentPage,
            builder: (_, value, __) {
              return Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(pages.length, (index) => _dot(index == value)));
            },
          ),
          SizedBox(height: size.height * 0.015),
        ],
      ),
    );
  }

  Widget _dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: 18,
      decoration: BoxDecoration(color: active ? Colors.black : Colors.grey, borderRadius: BorderRadius.circular(4)),
    );
  }
}
