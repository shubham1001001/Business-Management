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
      {'label': 'Sale order', 'icon': "assets/svg_icons/dashboard_sale_order.svg"},
      {'label': 'Customer', 'icon': "assets/svg_icons/dashboard_customer_icon.svg"},
      {'label': 'Item', 'icon': "assets/svg_icons/dashboard_item_icon.svg"},
      {'label': 'Rent', 'icon': "assets/svg_icons/dashboard_rent_icon.svg"},
      {'label': 'Day book', 'icon': "assets/svg_icons/dashboard_day_book.svg"},

      {'label': 'Trip', 'icon': "assets/svg_icons/dashboard_trip_icon.svg"},
    ];

    // Group into columns with 2 items each
    List<List<Map<String, String>>> columns = [];
    for (int i = 0; i < items.length; i += 2) {
      columns.add([items[i], if (i + 1 < items.length) items[i + 1]]);
    }

    return SizedBox(
      width: double.infinity,
      height: isLandscape ? size.height * 0.85 : size.height * 0.35,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: columns.map((columnItems) {
              return Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: columnItems.map((item) {
                    return GestureDetector(
                      onTap: () {
                        final routeMap = {'Item': AppRoutesName.itemListScreen, 'Trip': AppRoutesName.tripSummaryScreen, 'Sale order': AppRoutesName.addTransportationScreen};

                        final label = item['label'];
                        final route = routeMap[label];
                        if (route != null) {
                          Navigator.of(context).pushNamed(route);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: QuickLink(icon: item['icon'].toString(), label: item['label'].toString()),
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
