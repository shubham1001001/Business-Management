import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/screens/Generate/widgets/cart_widgets.dart';

import '../../providers/generate_provider/generate_provider.dart';

class GenerateBottomSheet extends StatelessWidget {
  const GenerateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final items = [
      {'label': 'Item', 'icon': "assets/icons/g1.png"},
      {'label': 'Account', 'icon': "assets/icons/g2.png"},
      {'label': 'Vehicle', 'icon': "assets/icons/g3.png"},
      {'label': 'Unit', 'icon': "assets/icons/g04.png"},
      {'label': 'Vendor', 'icon': "assets/icons/g5.png"},
      {'label': 'Customer', 'icon': "assets/icons/g6.png"},
      {'label': 'Warehouse', 'icon': "assets/icons/g7.png"},
      {'label': 'Point', 'icon': "assets/icons/g8.png"},
      {'label': 'Alert', 'icon': "assets/icons/g9.png"},
      {'label': 'Staff', 'icon': "assets/icons/g10.png"},
      // Add more if needed
    ];

    // Split items into pages of 10 (2 rows × 5 items)
    List<List<Map<String, String>>> pages = [];
    for (int i = 0; i < items.length; i += 10) {
      pages.add(items.sublist(i, (i + 10 > items.length) ? items.length : i + 10));
    }

    final PageController controller = PageController();
    final ValueNotifier<int> currentPage = ValueNotifier<int>(0);

    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [Text("Generate", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))],
          ),
          const SizedBox(height: 16),

          // PageView with 2-row layout
          SizedBox(
            height: size.height * 0.35,
            child: PageView.builder(
              controller: controller,
              itemCount: pages.length,
              onPageChanged: (index) => currentPage.value = index,
              itemBuilder: (context, pageIndex) {
                final pageItems = pages[pageIndex];
                return GridView.count(
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.7,
                  crossAxisCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  children: pageItems.map((item) {
                    return GestureDetector(
                      onTap: () {
                        context.read<GenerateProvider>().select(item['label'].toString());
                        Navigator.pop(context);
                      },
                      child: GenerateCart(icon: item['icon'].toString(), label: item['label'].toString()),
                    );
                  }).toList(),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Page indicators
          ValueListenableBuilder<int>(
            valueListenable: currentPage,
            builder: (_, value, __) {
              return Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(pages.length, (index) => _dot(index == value)));
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: active ? 18 : 6,
      decoration: BoxDecoration(color: active ? Colors.black : Colors.grey, borderRadius: BorderRadius.circular(4)),
    );
  }
}

// class GenerateBottomSheet extends StatelessWidget {
//   const GenerateBottomSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       {'label': 'Item', 'icon': "assets/icons/g1.png"},
//       {'label': 'Account', 'icon': "assets/icons/g2.png"},
//       {'label': 'Vehicle', 'icon': "assets/icons/g3.png"},
//       {'label': 'Unit', 'icon': "assets/icons/g04.png"},
//       {'label': 'Vendor', 'icon': "assets/icons/g5.png"},
//       {'label': 'Customer', 'icon': "assets/icons/g6.png"},
//       {'label': 'Warehouse', 'icon': "assets/icons/g7.png"},
//       {'label': 'Point', 'icon': "assets/icons/g8.png"},
//       {'label': 'Alert', 'icon': "assets/icons/g9.png"},
//       {'label': 'Staff', 'icon': "assets/icons/g10.png"},
//     ];
//
//     final width = MediaQuery.of(context).size.width;
//     final crossAxisCount = width < 400 ? 3 : 5;
//
//     return Padding(
//       padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [const Text("Generate", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))],
//           ),
//           const SizedBox(height: 16),
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const AlwaysScrollableScrollPhysics(),
//             itemCount: items.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.7),
//             itemBuilder: (context, index) {
//               final item = items[index];
//               return GestureDetector(
//                 onTap: () {
//                   context.read<GenerateProvider>().select(item['label'].toString());
//                   Navigator.pop(context);
//                 },
//                 child: GenerateCart(icon: item['icon'].toString(), label: item['label'].toString()),
//                 // Container(
//                 //   decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
//                 //   child: Column(
//                 //     mainAxisAlignment: MainAxisAlignment.center,
//                 //     children: [
//                 //       Icon(item['icon'] as IconData, size: 32),
//                 //       const SizedBox(height: 8),
//                 //       Text(item['label'].toString(), style: const TextStyle(fontSize: 13)),
//                 //     ],
//                 //   ),
//                 // ),
//               );
//             },
//           ),
//           const SizedBox(height: 16),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [_dot(true), _dot(false)]),
//           const SizedBox(height: 12),
//         ],
//       ),
//     );
//   }
//
//   Widget _dot(bool active) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       height: 6,
//       width: active ? 18 : 6,
//       decoration: BoxDecoration(color: active ? Colors.black : Colors.grey, borderRadius: BorderRadius.circular(4)),
//     );
//   }
// }
