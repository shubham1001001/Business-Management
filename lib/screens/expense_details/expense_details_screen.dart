import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/screens/expense_details/widgets/audio_wave_section.dart';
import 'package:sales/screens/expense_details/widgets/expence_card.dart';

import '../../providers/expense_details/expense_details_provider.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  const ExpenseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      appBar: AppBar(title: const Text("Expense Details"), leading: const BackButton()),
      body: Padding(
        padding: AppSpacing.allPadding8,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Card
              ExpenseTopCard(),
              AppSpacing.mediumHeight16,

              // Item list
              const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Items", style: AppTextStyles.greyBoldText20),
                    Text("Amount", style: AppTextStyles.greyBoldText20),
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade300),
              AppSpacing.smallHeight,

              Consumer<ExpenseDetailProvider>(
                builder: (_, provider, __) => Column(
                  children: provider.items.map((e) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(e.name)),
                        Flexible(child: Text("₹ ${e.amount.toStringAsFixed(2)}")),
                      ],
                    );
                  }).toList(),
                ),
              ),
              Divider(color: Colors.grey.shade300),
              AppSpacing.mediumHeight16,
              Selector<ExpenseDetailProvider, double>(
                selector: (_, p) => p.totalAmount,
                builder: (_, total, __) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppSpacing.mediumWidth16,
                    const Text("Total amount", style: AppTextStyles.boldText),

                    Text("₹ ${total.toStringAsFixed(2)}", style: AppTextStyles.boldText),
                  ],
                ),
              ),

              AppSpacing.largeHeight,
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Note", style: AppTextStyles.titleListTile),
              ),
              AppSpacing.smallWidth10,

              // Audio Wave & Play
              AudioWaveformWidget(audioUrl: 'http://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Sevish_-__nbsp_.mp3'),
            ],
          ),
        ),
      ),
    );
  }
}
