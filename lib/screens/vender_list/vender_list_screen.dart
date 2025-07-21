import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../core/constants/colors.dart';
import '../../providers/vender_list_provider/vender_list_provider.dart';
import '../../routes/app_routes_name.dart';

class VenderListScreen extends StatelessWidget {
  const VenderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 1,

        title: Text("Vendor List"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutesName.addVehicleScreen);
            },
            child: Text("Add Vendor", style: AppTextStyles.appBarRedBoldText),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<VenderListProvider>(
            builder: (BuildContext context, VenderListProvider provider, Widget? child) {
              return Padding(
                padding: AppSpacing.screenPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        children: ['All', 'Data', 'No data'].map((filter) {
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
                    Padding(padding: AppSpacing.allPadding8, child: Image.asset("assets/icons/Vector (3).png")),
                  ],
                ),
              );
            },
          ),

          Consumer<VenderListProvider>(
            builder: (BuildContext context, VenderListProvider provider, Widget? child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: provider.filteredOrders.length,
                  padding: AppSpacing.allPadding12,
                  itemBuilder: (context, index) {
                    final order = provider.filteredOrders[index];
                    final statusColor = order.status == 'Draft' ? AppColors.redColor : AppColors.redColor;
                    //    Navigator.of(context, rootNavigator: true).pushNamed(AppRoutesName.vehicleOverviewScreen);
                    return Padding(
                      padding: AppSpacing.allPadding5,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(AppRoutesName.venderDetailScreen);
                        },
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
                                padding: EdgeInsets.all(screenWidth * 0.025),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: AppSpacing.allPadding5,
                                          child: Stack(
                                            alignment: AlignmentDirectional.center,
                                            children: [
                                              Image.asset("assets/icons/user_icon.png"),
                                              Padding(padding: const EdgeInsets.all(6.0), child: Icon(Icons.person_outline)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.03),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(order.customerName, style: AppTextStyles.backBoldText),
                                            Text(order.description, style: AppTextStyles.greyBoldText),
                                          ],
                                        ),
                                        Spacer(),
                                        Text(
                                          "₹${order.balance}",
                                          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: size.width * 0.03),
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
              );
            },
          ),
        ],
      ),
    );
  }
}
