import 'package:flutter/cupertino.dart';
import 'package:sales/core/constants/spacing.dart';

import '../../../core/constants/text_styles.dart';

class SalesInfo extends StatelessWidget {
  final String title;
  final String amount;

  const SalesInfo({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppTextStyles.boldText),
        AppSpacing.smallHeight10,
        Text(amount, style: AppTextStyles.blueBoldText),
      ],
    );
  }
}
