import 'package:flutter/material.dart';
import 'package:sales/core/constants/spacing.dart';

import '../../../core/constants/svg_picture_widgets.dart';
import '../../../core/constants/text_styles.dart';

class SalesInfo extends StatelessWidget {
  final String title;
  final String amount;

  const SalesInfo({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.boldTextW700),
        AppSpacing.extraSmallHeight,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPictureWidgets(svgString: "assets/svg_icons/rupee_icon_card.svg", color: Colors.indigo, size: 13.0),
            AppSpacing.extraSmallWidth,
            Text(amount, style: AppTextStyles.blueBoldText),
          ],
        ),
      ],
    );
  }
}
