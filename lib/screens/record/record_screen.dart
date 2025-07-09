import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../models/record_selections_model.dart';
import '../../models/taps_model.dart';
import '../../providers/record_provider.dart';

class RecordScreen extends StatelessWidget {
  RecordScreen({super.key});

  final List<TapsModel> tabs = [
    TapsModel(
      title: 'Sales',
      Images: Image.asset("assets/icons/Sales var.png", alignment: Alignment.center),
    ), //
    TapsModel(
      title: 'Purchase',
      Images: Image.asset("assets/icons/Purchase var.png", alignment: Alignment.center),
    ),
    TapsModel(
      title: 'Bank',
      Images: Image.asset("assets/icons/Bank var.png", alignment: Alignment.center),
    ),
    TapsModel(
      title: 'Cash',
      Images: Image.asset("assets/icons/Cash var.png", alignment: Alignment.center),
    ),
    TapsModel(
      title: 'Expenses',
      Images: Image.asset("assets/icons/Expenses var.png", alignment: Alignment.center),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecordProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    //
    final showDetailedList = ['Bank', 'Cash', 'Expenses'].contains(provider.selectedTab);

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true, backgroundColor: AppColors.primary, elevation: 1),

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Tab Menu
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: screenheight * 0.15,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
              ),
              child: SizedBox(
                height: screenheight * 0.11,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: tabs.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 20),
                  itemBuilder: (context, index) {
                    final double buttonSize = screenWidth * 0.11;
                    final tab = tabs[index].title;
                    final isSelected = provider.selectedTab == tab;
                    return GestureDetector(
                      onTap: () => provider.setSelectedTab(tabs[index].title),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: buttonSize,
                            width: buttonSize,
                            decoration: BoxDecoration(color: isSelected ? AppColors.redcolor : Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                            child: Padding(padding: const EdgeInsets.only(left: 5, top: 8), child: tabs[index].Images),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tabs[index].title,
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // IF OVERVIEW (Sales, Purchase)
            if (!showDetailedList)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.count(
                    crossAxisCount: screenWidth > 600 ? 3 : 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.3,
                    children: provider.overviewItems.map((item) {
                      return buildCard(item);
                    }).toList(),
                  ),
                ),
              ),

            // IF DETAILED LIST (Bank, Cash, Expenses)
            if (showDetailedList)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(provider.selectedTab == "Expenses" ? "Overview" : "${provider.selectedTab} List", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      // Sub Filter Chips
                      Row(
                        children: [
                          Row(
                            children: provider.subFilters.map((filter) {
                              final isSelected = filter == provider.selectedSubFilter;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ChoiceChip(
                                  label: Text(filter),
                                  selected: isSelected,
                                  showCheckmark: false,
                                  selectedColor: AppColors.redcolor,
                                  onSelected: (_) => provider.setSubFilter(filter),
                                  backgroundColor: Colors.grey.shade200,
                                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                          Spacer(),
                          Padding(padding: const EdgeInsets.all(8.0), child: Image.asset("assets/icons/Vector (3).png")),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // List Cards
                      Expanded(
                        child: ListView.separated(
                          itemCount: provider.listItems.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = provider.listItems[index];
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.cardclip,
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12), topLeft: Radius.circular(15), bottomLeft: Radius.circular(12)),
                                  border: Border.all(color: Colors.grey),
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12), topLeft: Radius.circular(1), bottomLeft: Radius.circular(1)),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.grey100,
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: Colors.white),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(item.icon, size: 32, color: Colors.grey),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                                                Text("${item.count} items", style: const TextStyle(color: Colors.grey)),
                                              ],
                                            ),
                                          ),
                                          const Icon(Icons.more_vert),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      // FAB
      floatingActionButton: showDetailedList
          ? FloatingActionButton(
              backgroundColor: AppColors.redcolor,
              onPressed: () {},
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      // Bottom Nav
    );
  }

  Widget buildCard(RecordSection item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text("${item.count} items", style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(item.icon, color: Colors.red.shade300),
            ),
          ),
        ],
      ),
    );
  }
}
