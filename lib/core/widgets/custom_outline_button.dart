import 'package:flutter/material.dart';
import 'package:sales/core/constants/spacing.dart';

import '../constants/text_styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double widthFactor;
  final double verticalPadding;
  final Color borderColor;
  final Color textColor;
  final Color colors;

  const CustomOutlinedButton({Key? key, required this.text, required this.onPressed, this.widthFactor = 0.45, this.verticalPadding = 16, this.borderColor = Colors.red, this.textColor = Colors.red, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: colors),
      child: SizedBox(
        width: size.width * widthFactor,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor,
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            side: BorderSide(color: borderColor),
            shape: RoundedRectangleBorder(borderRadius: AppSpacing.kMediumRadius),
          ),
          child: Text(text, style: AppTextStyles.customButtonTextStyle),
        ),
      ),
    );
  }
}
