import 'package:flutter/material.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';

class VenderDetailScreen extends StatelessWidget {
  const VenderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Vendor Details'), leading: const BackButton()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 64, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Card
            Container(
              padding: AppSpacing.allPadding16,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: AppColors.cardmainColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Vendor name', style: TextStyle(color: AppColors.redColor, fontSize: 20))],
                      ),
                      Text("+91 8152369874", style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 15),
                      const Text('Payable', style: TextStyle(color: AppColors.greyText)),
                      Row(
                        children: [
                          Text("₹ ", style: TextStyle(fontSize: 20, color: AppColors.greyText)),
                          Text("00.00"),
                        ],
                      ),
                    ],
                  ),
                  // Right info
                  SizedBox(width: size.width * 0.2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [Icon(Icons.edit_outlined), const SizedBox(width: 20), Icon(Icons.delete_outlined), const SizedBox(width: 20), Icon(Icons.more_vert)]),
                      SizedBox(height: size.height * 0.04),
                      // const Text('Outstanding', style: TextStyle(color: AppColors.greyText)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [_PaymentItem(title: "Outstanding", amount: "00.00")],
                      ),
                      // Row(
                      //   children: [
                      //     Text("₹ ", style: TextStyle(fontSize: 20, color: AppColors.greyText)),
                      //     Text("00.00"),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.025),

            Text("Address"),
            SizedBox(height: size.height * 0.01),
            Text("House no: 222, uphill,street - 45, majortown (po)Kottayam, 600015, Kerala", style: TextStyle(color: AppColors.greyText)),
            SizedBox(height: size.height * 0.01),
            Text("Description"),
            Text("is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'sstandard dummy text ever since the 1500s", style: TextStyle(color: AppColors.greyText)),
          ],
        ),
      ),
    );
  }
}

class _PaymentItem extends StatelessWidget {
  final String title;
  final String amount;

  const _PaymentItem({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black),
            children: [
              const TextSpan(text: "₹ "),
              TextSpan(
                text: amount,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
