import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import '../../providers/purchase_bill_overview/purchase_bill_overview_provider.dart';

class PurchaseBillOverviewScreen extends StatelessWidget {
  const PurchaseBillOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 1,

        title: Text("Purchase Bill Overview"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("+ Add", style: AppTextStyles.appBarRedBoldText),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<PurchaseBillOverviewProvider>(
            builder: (BuildContext context, PurchaseBillOverviewProvider provider, Widget? child) {
              return Padding(
                padding: AppSpacing.screenPadding,
                child: Row(
                  children: [
                    Image.asset("assets/icons/Vector (2).png"),
                    Expanded(
                      child: Wrap(
                        children: ['All', 'Recently', 'Date'].map((filter) {
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
                  ],
                ),
              );
            },
          ),

          Consumer<PurchaseBillOverviewProvider>(
            builder: (BuildContext context, PurchaseBillOverviewProvider provider, Widget? child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: provider.filteredOrders.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final order = provider.filteredOrders[index];
                    final statusColor = order.status == 'Draft' ? AppColors.redColor : AppColors.redColor;

                    return Padding(
                      padding: AppSpacing.allPadding5,
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
                                          Text("₹100"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [Text(DateFormat('dd.MM.yyyy').format(order.date), style: AppTextStyles.greyText12)],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Customer balance ", style: AppTextStyles.titleListTile),
                                          Text(
                                            "₹${order.balance}",
                                            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      // if (order.status == 'Draft')
                                      //   Column(
                                      //     mainAxisAlignment: MainAxisAlignment.start,
                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                      //     children: [
                                      //       Text(
                                      //         order.status,
                                      //         style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                                      //       ),
                                      //     ],
                                      //   ),
                                      SizedBox(width: 5),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //
                                      //   children: [
                                      //     if (order.status != 'Draft')
                                      //       Text(
                                      //         order.status,
                                      //         style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                                      //       ),
                                      //     const SizedBox(width: 10),
                                      //     if (order.status == 'Draft')
                                      //       OutlinedButton(
                                      //         onPressed: () {},
                                      //         style: OutlinedButton.styleFrom(
                                      //           foregroundColor: AppColors.appBackColor, // text/icon color
                                      //           side: const BorderSide(color: Colors.grey), // 👈 outline color
                                      //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                      //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                      //         ),
                                      //         child: const Text("Process"),
                                      //       ),
                                      //   ],
                                      // ),
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
