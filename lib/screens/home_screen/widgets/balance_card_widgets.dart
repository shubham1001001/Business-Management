import 'package:flutter/material.dart';

import '../../../core/constants/spacing.dart';
import '../../../core/constants/svg_picture_widgets.dart';
import '../../../core/widgets/text_scale_widgets.dart';

class BalanceCard extends StatelessWidget {
  final String label;
  final String amount;
  final String icon;

  const BalanceCard({super.key, required this.label, required this.amount, required this.icon});

  // BalanceCard widget - FIXED
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final isLandscape = screen.width > screen.height;

    return Container(
      width: isLandscape ? screen.width * 0.2 : screen.width * 0.21,
      height: isLandscape ? screen.height * 0.39 : screen.height * 0.14,
      margin: AppSpacing.allPadding5,
      padding: EdgeInsets.symmetric(vertical: screen.height * 0.01, horizontal: screen.width * 0.02),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, top: 1),
              child: SizedBox(
                width: screen.width * 0.09,
                height: screen.height * 0.05,
                child: SvgPictureWidgets(svgString: icon),
                // Image.asset(icon, fit: BoxFit.contain),
              ),
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              label,
              style: TextStyle(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 45), fontWeight: FontWeight.w500),
            ),
          ),
          AppSpacing.smallHeight6,
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPictureWidgets(svgString: "assets/svg_icons/rupee_icon_card.svg", size: 12.20),
                AppSpacing.extraSmallWidth,
                Text(
                  amount,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 42)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
