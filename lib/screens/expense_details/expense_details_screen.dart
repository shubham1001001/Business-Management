import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';
import 'package:sales/screens/expense_details/widgets/audio_wave_section.dart';
import 'package:sales/screens/expense_details/widgets/expence_card.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/svg_picture_widgets.dart';
import '../../providers/expense_details/expense_details_provider.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  ExpenseDetailsScreen({super.key});

  final titleTextOpacity50 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'OpenSans',
    color: Colors.black.withOpacity(0.6), // 50% opacity
  );
  final titleTextOpacity80 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: 'OpenSans',
    color: Colors.black.withOpacity(0.6), // 50% opacity
  );

  final appBlackText18W400 = TextStyle(fontSize: 20, fontFamily: 'OpenSans', fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8));
  static final openSansSemiBold = TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black.withOpacity(0.8));
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 27,
        title: const Text("Expense Details", style: AppTextStyles.appBarBlackText),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              AppSpacing.largeHeight24,
              // Top Card
              ExpenseTopCard(),
              AppSpacing.mediumHeight21,

              // Item list
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Items", style: titleTextOpacity50),
                    Text("Amount", style: titleTextOpacity80),
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade300),
              AppSpacing.smallHeight,

              Consumer<ExpenseDetailProvider>(
                builder: (_, provider, __) => Column(
                  children: provider.items.map((e) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Text(e.name, style: openSansSemiBold)),
                            Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPictureWidgets(svgString: "assets/svg_icons/rupee_icon_card.svg", color: AppColors.appBlackColor, size: 11.0),
                                  AppSpacing.extraSmallWidth,
                                  Text(e.amount.toStringAsFixed(2), style: openSansSemiBold),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AppSpacing.mediumHeight16,
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
                    Text("Total amount", style: appBlackText18W400),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPictureWidgets(svgString: "assets/svg_icons/rupee_icon_card.svg", color: AppColors.appBlackColor, size: 15.0),
                        AppSpacing.extraSmallWidth,
                        Text("${total.toStringAsFixed(2)}", style: appBlackText18W400),
                      ],
                    ),
                  ],
                ),
              ),

              AppSpacing.largeHeight40,
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Note", style: AppTextStyles.openSansFontStyleTextW400),
              ),
              AppSpacing.mediumHeight16,

              // Audio Wave & Play
              AudioWaveformWidget(audioUrl: 'http://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Sevish_-__nbsp_.mp3'),
            ],
          ),
        ),
      ),
    );
  }
}
