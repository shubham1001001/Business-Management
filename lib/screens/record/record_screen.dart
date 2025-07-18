import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../models/record_selections_model.dart';
import '../../models/taps_model.dart';
import '../../providers/record_provider.dart';
import '../../routes/app_routes_name.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape = screenWidth > screenHeight;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true, backgroundColor: AppColors.primary, elevation: 1),

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<RecordProvider>(
          builder: (BuildContext context, RecordProvider provider, Widget? child) {
            final showDetailedList = ['Bank', 'Cash', 'Expenses'].contains(provider.selectedTab);

            return Column(
              children: [
                // Top Tab Menu
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: isLandscape ? screenHeight * 0.4 : screenHeight * 0.15,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: AppSpacing.kSmallRadius,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
                  ),
                  child: SizedBox(
                    height: isLandscape ? screenHeight * 0.28 : screenHeight * 0.13,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: tabs.length,
                      separatorBuilder: (_, __) => AppSpacing.mediumWidth,
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
                                decoration: BoxDecoration(color: isSelected ? AppColors.redColor : Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                                child: Padding(padding: const EdgeInsets.only(left: 5, top: 8), child: tabs[index].Images),
                              ),
                              AppSpacing.extraSmallHeight,
                              Text(tabs[index].title, style: AppTextStyles.titleListTile),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.026),

                // IF OVERVIEW (Sales, Purchase)
                if (!showDetailedList)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.026),
                      child: GridView.count(
                        crossAxisCount: screenWidth > 600 ? 3 : 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.3,
                        children: provider.overviewItems.map((item) {
                          return InkWell(
                            onTap: () {
                              print(item.title);
                              if (item.title == "Bill") {
                                Navigator.of(context).pushNamed(AppRoutesName.purchaseBillOverviewScreen);
                              }
                            },
                            child: Padding(padding: AppSpacing.allPadding5, child: buildCard(item)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                // IF DETAILED LIST (Bank, Cash, Expenses)
                if (showDetailedList)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.026),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(provider.selectedTab == "Expenses" ? "Overview" : "${provider.selectedTab} List", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          AppSpacing.smallHeight10,
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
                                      selectedColor: AppColors.redColor,
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
                          SizedBox(height: screenHeight * 0.026),
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
                                      color: AppColors.cardClip,
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
                                          padding: AppSpacing.allPadding16,
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.grey100,
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(color: Colors.white),
                                                ),
                                                child: Padding(
                                                  padding: AppSpacing.allPadding8,
                                                  child: Icon(item.icon, size: 32, color: Colors.grey),
                                                ),
                                              ),
                                              AppSpacing.smallWidth10,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(item.title, style: AppTextStyles.titleListTile),
                                                    Text("${item.count} items", style: AppTextStyles.subtitleGrey),
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
            );
          },
        ),
      ),
      // FAB
      floatingActionButton: Consumer<RecordProvider>(
        builder: (context, provider, child) {
          final showDetailedList = ['Bank', 'Cash', 'Expenses'].contains(provider.selectedTab);
          print(showDetailedList);
          return showDetailedList
              ? FloatingActionButton(
                  backgroundColor: AppColors.redColor,
                  onPressed: () {},
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : SizedBox.shrink();
        },
      ),

      // Bottom Nav
    );
  }

  Widget buildCard(RecordSection item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppSpacing.kSmallRadius,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
      ),
      padding: AppSpacing.allPadding12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: AppTextStyles.title16),
          AppSpacing.extraSmallHeight,
          Text("${item.count} items", style: AppTextStyles.greyText),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: AppSpacing.allPadding10,
              child: Icon(item.icon, color: Colors.red.shade300),
            ),
          ),
        ],
      ),
    );
  }
}
