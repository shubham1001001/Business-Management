import 'package:flutter/material.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/screens/Generate/widgets/cart_widgets.dart';

import '../../routes/app_routes_name.dart';

class GenerateBottomSheet extends StatelessWidget {
  GenerateBottomSheet({super.key});
  final items = [
    {'label': 'Item', 'icon': "assets/icons/g1.png"},
    {'label': 'Account', 'icon': "assets/svg_icons/generate_account_icon.svg"},
    {'label': 'Vehicle', 'icon': "assets/svg_icons/generate_vehicle_icon.svg"},
    {'label': 'Unit', 'icon': "assets/svg_icons/generate_unit_icon.svg"},
    {'label': 'Vendor', 'icon': "assets/svg_icons/generate_vendor_icon.svg"}, //
    {'label': 'Customer', 'icon': "assets/svg_icons/generate_customer_icon.svg"},
    {'label': 'Warehouse', 'icon': "assets/svg_icons/generate_warehouse_icon.svg"},
    {'label': 'Point', 'icon': "assets/svg_icons/generate_point_icon.svg"},
    {'label': 'Alert', 'icon': "assets/icons/g9.png"},
    {'label': 'Staff', 'icon': "assets/svg_icons/generate_staff_icon.svg"},
    // Add more if needed
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final isLandscape = screenWidth > screenHeight;
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
            height: isLandscape ? size.height * 0.5 : size.height * 0.35,
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
                        final routeMap = {'Vendor': AppRoutesName.venderListScreen, 'Staff': AppRoutesName.addStaffScreen, 'Vehicle': AppRoutesName.vehicleOverviewScreen, 'Account': AppRoutesName.accountSummaryScreen, 'Item': AppRoutesName.itemCreateScreen};

                        final label = item['label'].toString();
                        final route = routeMap[label];

                        if (route != null) {
                          Navigator.pop(context); // only if needed
                          Navigator.of(context).pushNamed(route);
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
