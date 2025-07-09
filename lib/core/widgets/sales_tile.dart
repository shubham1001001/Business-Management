import 'package:flutter/material.dart';

import '../../core/constants/text_styles.dart';
import 'status_chip.dart';

class SalesTile extends StatelessWidget {
  final String name, date, status;
  final double total, balance;
  final VoidCallback? onPressed;

  const SalesTile({super.key, required this.name, required this.date, required this.status, required this.total, required this.balance, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Customer name", style: AppTextStyles.subtitle),
            Text(name, style: AppTextStyles.title),
            const SizedBox(height: 4),
            Text("Customer balance", style: AppTextStyles.subtitle),
            Text("₹ $balance", style: TextStyle(color: balance > 10000 ? Colors.red : Colors.green)),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total amount ₹ $total"),
                StatusChip(status: status),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date, style: AppTextStyles.small),
                if (status == "Draft") ElevatedButton(onPressed: onPressed, child: Text("Process")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
