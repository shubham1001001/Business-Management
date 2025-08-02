import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/svg_picture_widgets.dart';
import '../../../core/constants/text_styles.dart';
import '../../../core/widgets/delete_confirmation_dialog_widget.dart';

class ExpenseTopCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: AppSpacing.allPadding12,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: AppSpacing.kMediumRadius,
        color: AppColors.cardmainColor,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 3, offset: Offset(0, 4))],
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'EX - 526',
                      style: TextStyle(color: AppColors.redColor, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                AppSpacing.extraSmallHeight,
                Text("Expense account", style: AppTextStyles.smallW400),
                AppSpacing.mediumHeight21,
                Text('Lorem ipsum', style: AppTextStyles.openSansRegular),
                AppSpacing.extraSmallHeight,
                Row(children: [Text("12.02.20250", style: AppTextStyles.openSansRegular)]),
              ],
            ),
            // Right info
            SizedBox(width: size.width * 0.2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPictureWidgets(svgString: "assets/svg_icons/edit_icon.svg", color: AppColors.appBlackColor, size: 15.0),
                    AppSpacing.largeWidth,
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => DeleteConfirmationDialog(onConfirm: () {}),
                        );
                      },
                      child: SvgPictureWidgets(svgString: "assets/svg_icons/delete_svg_icon.svg", size: 17.0),
                    ),
                    AppSpacing.largeWidth,
                    InkWell(onTap: () async {}, child: Image.asset("assets/icons/share_button.png", width: 15)),
                  ],
                ),
                AppSpacing.largeHeight50,
                // const Text('Outstanding', style: TextStyle(color: AppColors.greyText)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [_PaymentItem(title: "Total amount", amount: "150.00")],
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
        Text(title, style: AppTextStyles.openSansRegular),
        AppSpacing.extraSmallHeight,
        Row(
          children: [
            SvgPictureWidgets(svgString: "assets/svg_icons/rupee_icon_card.svg", color: AppColors.appBlackColor, size: 15.0),
            AppSpacing.smallWidth6,
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [TextSpan(text: amount, style: AppTextStyles.openSansRegular20)],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
