import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../core/constants/svg_picture_widgets.dart';
import '../../core/widgets/custom_dropdown_widget.dart';
import '../../models/record_selections_model.dart';
import '../../models/taps_model.dart';
import '../../providers/record_provider.dart';
import '../../routes/app_routes_name.dart';

class RecordScreen extends StatelessWidget {
  RecordScreen({super.key});

  final List<TapsModel> tabs = [
    TapsModel(title: 'Sales', Images: "assets/svg_icons/sales_icons.svg"), //
    TapsModel(title: 'Purchase', Images: "assets/svg_icons/Receipt_icon.png"),
    TapsModel(title: 'Bank', Images: "assets/svg_icons/g_bank_icon.svg"),
    TapsModel(title: 'Cash', Images: "assets/svg_icons/coin.svg.svg"),
    TapsModel(title: 'Expenses', Images: "assets/svg_icons/expenses_icon.svg"),
  ];
  final subTitleTextStyle = TextStyle(fontSize: 12, fontFamily: 'OpenSans', color: Colors.grey.shade800, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape = screenWidth > screenHeight;
    double _scale = 1.0;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true, backgroundColor: AppColors.primary, elevation: 1),

      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<RecordProvider>(
          builder: (BuildContext context, RecordProvider provider, Widget? child) {
            final showDetailedList = ['Bank', 'Cash', 'Expenses'].contains(provider.selectedTab);
            final isExpenses = ['Expenses'].contains(provider.selectedTab);

            return Column(
              children: [
                // Top Tab Menu
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: isLandscape ? screenHeight * 0.5 : screenHeight * 0.15,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: AppSpacing.kSmallRadius,
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
                  ),
                  child: SizedBox(
                    height: isLandscape ? screenHeight * 0.40 : screenHeight * 0.13,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: tabs.length,
                      separatorBuilder: (_, __) => AppSpacing.smallWidth12,
                      itemBuilder: (context, index) {
                        final double buttonSize = screenWidth * 0.15;
                        final tab = tabs[index].title;
                        final isSelected = provider.selectedTab == tab;
                        return GestureDetector(
                          onTap: () {
                            print("Tab Click");
                            provider.setSelectedTab(tabs[index].title);
                          },
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: buttonSize,
                                height: buttonSize,
                                decoration: BoxDecoration(color: isSelected ? AppColors.redColor : Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween<double>(begin: 1.0, end: isSelected ? 1.5 : 1.0),
                                    duration: Duration(milliseconds: 200),
                                    builder: (context, scale, child) {
                                      return Transform.scale(
                                        alignment: Alignment.center,
                                        scale: scale,
                                        child: tabs[index].title == "Purchase" ? Image.asset(tabs[index].Images, fit: BoxFit.contain, width: screenWidth * 0.085) : SvgPictureWidgets(size: screenWidth * 0.075, svgString: tabs[index].Images),
                                      );
                                    },
                                  ),
                                ),
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
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.count(
                        crossAxisCount: screenWidth > 600 ? 3 : 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1.1,
                        children: provider.overviewItems.map((item) {
                          return InkWell(
                            onTap: () {
                              final routeMap = {"Bill": AppRoutesName.purchaseBillOverviewScreen, "Sales Order": '/details'};

                              final route = routeMap[item.title];
                              if (route != null) {
                                Navigator.of(context).pushNamed(route);
                              }
                            },
                            child: buildCard(item),
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
                          Text(isExpenses ? "Overview" : "${provider.selectedTab} Overview", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          AppSpacing.smallHeight10,
                          // Sub Filter Chips
                          Row(
                            children: [
                              isExpenses
                                  ? Row(
                                      children: provider.subFilters.map((filter) {
                                        final isSelected = filter == provider.selectedSubFilter;
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 18),
                                          child: ChoiceChip(
                                            padding: AppSpacing.allPadding5,
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
                                    )
                                  : Container(
                                      height: 45, // Smaller height
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: AppSpacing.kMediumRadius10,
                                        color: Colors.white,
                                      ),
                                      child: CustomDropdown<FilterDropItem>(
                                        isExpanded: false,
                                        value: provider.selectedFilter,
                                        items: provider.dropItem,
                                        onChanged: (filter) {
                                          if (filter != null) provider.setFilter(filter);
                                        },
                                      ),
                                    ),
                              Spacer(),
                              Padding(
                                padding: AppSpacing.allPadding8,
                                child: SvgPictureWidgets(size: 21.0, svgString: "assets/svg_icons/filter_v.svg"),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.026),
                          // List Cards
                          Expanded(
                            child: ListView.separated(
                              itemCount: isExpenses ? provider.dropItemSelect.length : provider.listItems.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final RecordSection item = isExpenses ? provider.dropItemSelect[index] as RecordSection : provider.listItems[index];

                                return Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: InkWell(
                                    onTap: () {
                                      final routeMap = {
                                        "Expenses": AppRoutesName.expenseDetailsScreen,
                                        // "case": AppRoutesName.caseDetailsScreen,
                                        // "bank": AppRoutesName.bankDetailsScreen,
                                      };

                                      final route = routeMap[provider.selectedTab];
                                      if (route != null) {
                                        Navigator.pushNamed(context, route);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.cardClip,
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(13), bottomLeft: Radius.circular(10)),
                                        border: Border.all(color: Colors.grey),
                                      ),

                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10), topLeft: Radius.circular(1), bottomLeft: Radius.circular(1)),
                                            border: Border.all(color: Colors.white),
                                          ),
                                          child: Padding(
                                            padding: AppSpacing.allPadding10,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: AppSpacing.allPadding8,
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      SvgPictureWidgets(size: 37.0, svgString: "assets/svg_icons/bg_icon.svg"),
                                                      SvgPictureWidgets(size: 18.0, svgString: item.icon),
                                                    ],
                                                  ),
                                                ),
                                                AppSpacing.smallWidth10,
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(item.title, style: AppTextStyles.titleBold16),
                                                      AppSpacing.smallHeight6,
                                                      Text(isExpenses ? "${item.date}" : "${item.count} items", style: subTitleTextStyle),
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
          final showDetailedList = ['Expenses'].contains(provider.selectedTab);
          print(showDetailedList);
          return showDetailedList
              ? FloatingActionButton(
                  backgroundColor: AppColors.redColor,
                  onPressed: () {},
                  child: const SvgPictureWidgets(size: 30.0, svgString: "assets/svg_icons/add_icon.svg", color: Colors.white),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: AppTextStyles.title),
          Text("${item.count} items", style: AppTextStyles.backText),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: AppSpacing.allPadding10,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPictureWidgets(size: 38.0, svgString: "assets/svg_icons/bg_icon.svg"),
                  SvgPictureWidgets(size: 18.0, svgString: item.icon),
                ],
              ),
            ),
          ),
          AppSpacing.extraSmallHeight,
        ],
      ),
    );
  }
}
