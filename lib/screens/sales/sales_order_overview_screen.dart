import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../providers/sales_order_provider.dart';

class SalesOrderOverviewScreen extends StatelessWidget {
  const SalesOrderOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SalesOrderProvider>(context);
    final orders = provider.filteredOrders;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 1,

        title: const Text(
          "Sales Order Overview",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/details');
            },
            child: const Text(
              "+ Add",
              style: TextStyle(color: AppColors.redcolor, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<SalesOrderProvider>(
            builder: (BuildContext context, SalesOrderProvider provider, Widget? child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Image.asset("assets/icons/Vector (2).png"),
                    Expanded(
                      child: Wrap(
                        children: ['All', 'Pending', 'Closed'].map((filter) {
                          final isSelected = filter == provider.filter;
                          final color = isSelected ? Colors.white : Colors.black;
                          final bgColor = isSelected ? AppColors.redcolor : Colors.grey.shade200;

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
                    Icon(Icons.info_outline_rounded, size: 30),
                  ],
                ),
              );
            },
          ),

          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final order = orders[index];
                final statusColor = order.status == 'Draft' ? AppColors.redcolor : Colors.green;

                return Padding(
                  padding: const EdgeInsets.all(5.0),
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
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12), topLeft: Radius.circular(3), bottomLeft: Radius.circular(3)),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Customer name",
                                        style: TextStyle(color: AppColors.appBackColor, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        order.customerName,
                                        style: const TextStyle(color: AppColors.greyText, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Total amount",
                                        style: TextStyle(color: AppColors.appBackColor, fontWeight: FontWeight.bold),
                                      ),
                                      Text("₹100", style: const TextStyle(fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("0001", style: const TextStyle(color: AppColors.greyText, fontSize: 12)),
                                      Text(DateFormat('dd.MM.yyyy').format(order.date), style: const TextStyle(color: AppColors.greyText, fontSize: 12)),
                                    ],
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
                                      const Text("Customer balance ", style: TextStyle(fontWeight: FontWeight.w500)),
                                      Text(
                                        "₹${order.balance}",
                                        style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                                      ),
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
                                  SizedBox(width: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
                                      if (order.status != 'Draft')
                                        Text(
                                          order.status,
                                          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                                        ),
                                      const SizedBox(width: 10),
                                      if (order.status == 'Draft')
                                        OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: AppColors.appBackColor, // text/icon color
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
          ),
        ],
      ),
    );
  }
}
