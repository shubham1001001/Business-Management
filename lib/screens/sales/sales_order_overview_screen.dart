import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/svg_picture_widgets.dart';
import '../../providers/sales_order_provider.dart';

class SalesOrderOverviewScreen extends StatelessWidget {
  const SalesOrderOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 1,

        title: const Text("Sales Order Overview", style: AppTextStyles.backText),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/details');
            },
            child: const Text("+ Add", style: AppTextStyles.appBarRedBoldText),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<SalesOrderProvider>(
            builder: (BuildContext context, SalesOrderProvider provider, Widget? child) {
              return Padding(
                padding: AppSpacing.screenPadding,
                child: Row(
                  children: [
                    Image.asset("assets/icons/Vector (2).png"),
                    Expanded(
                      child: Wrap(
                        children: ['All', 'Pending', 'Closed'].map((filter) {
                          final isSelected = filter == provider.filter;
                          final color = isSelected ? Colors.white : Colors.black;
                          final bgColor = isSelected ? AppColors.redColor : Colors.grey.shade200;

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: ChoiceChip(
                              showCheckmark: false,
                              label: Text(filter, style: TextStyle(color: color)),
                              selected: isSelected,
                              selectedColor: bgColor,
                              onSelected: (_) => provider.setFilter(filter),
                              backgroundColor: AppColors.primary,
                              labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SvgPictureWidgets(svgString: "assets/svg_icons/info_icon.svg", color: AppColors.appBlackColor, size: 26.0),
                  ],
                ),
              );
            },
          ),

          Consumer<SalesOrderProvider>(
            builder: (context, provider, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: provider.filteredOrders.length,
                  padding: AppSpacing.allPadding12,
                  itemBuilder: (context, index) {
                    final order = provider.filteredOrders[index];
                    final statusColor = order.status == 'Draft' ? AppColors.warningRedColor : Colors.green;
                    final balanceColor = order.status == 'Sold' || order.status == 'Draft' ? AppColors.warningRedColor : Colors.green;

                    return Padding(
                      padding: AppSpacing.allPadding8,
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
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12), topLeft: Radius.circular(3), bottomLeft: Radius.circular(3)),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Padding(
                              padding: AppSpacing.allPadding10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Customer name", style: AppTextStyles.backBoldText),
                                          Text(order.customerName, style: AppTextStyles.greyBoldText),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Text("Total amount", style: AppTextStyles.backBoldText),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(text: "₹", style: AppTextStyles.greyText20),
                                                TextSpan(text: " 100", style: AppTextStyles.greyBoldText),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [Text(DateFormat('dd.MM.yyyy').format(order.date), style: AppTextStyles.greyBoldText)],
                                      ),
                                    ],
                                  ),
                                  AppSpacing.largeHeight40,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Customer balance ", style: AppTextStyles.backBoldText),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(text: "₹", style: AppTextStyles.greyText20),
                                                TextSpan(
                                                  text: " ${order.balance}",
                                                  style: TextStyle(color: balanceColor, fontWeight: FontWeight.bold, fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Text(
                                          //  ,
                                          //   style: TextStyle(color: balanceColor, fontWeight: FontWeight.bold),
                                          // ),  Text(
                                          //   "₹${order.balance}",
                                          //   style: TextStyle(color: balanceColor, fontWeight: FontWeight.bold),
                                          // ),
                                        ],
                                      ),
                                      if (order.status == 'Draft')
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              order.status,
                                              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      AppSpacing.extraSmallWidth,
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                        children: [
                                          if (order.status != 'Draft')
                                            Text(
                                              order.status,
                                              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                                            ),
                                          AppSpacing.smallHeight10,
                                          if (order.status == 'Draft')
                                            OutlinedButton(
                                              onPressed: () {},
                                              style: OutlinedButton.styleFrom(
                                                foregroundColor: AppColors.appBlackColor, // text/icon color
                                                side: const BorderSide(color: Colors.grey), // 👈 outline color
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                              ),
                                              child: const Text("Process"),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
