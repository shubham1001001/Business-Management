import 'package:flutter/material.dart';
import 'package:sales/core/constants/spacing.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/svg_picture_widgets.dart';

class GenerateCart extends StatelessWidget {
  final String icon;
  final String label;

  const GenerateCart({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final screenWidth = screen.width;
    final screenHeight = screen.height;
    final isLandscape = screenWidth > screenHeight;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: isLandscape ? screen.width * 0.06 : screen.width * 0.14,
          height: isLandscape ? screen.width * 0.06 : screen.width * 0.14,
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade300, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                spreadRadius: 2,
                offset: Offset(0, 4), // shadow below the box
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: AppSpacing.allPadding5,
                child: label != "Item"
                    ? label != "Alert"
                          ? SvgPictureWidgets(svgString: icon, size: 30.0)
                          : Image.asset(icon, fit: BoxFit.fitWidth)
                    : Image.asset(icon, fit: BoxFit.fitWidth),
              ),
              // Image.asset(icon, fit: BoxFit.fitWidth), //
            ],
          ),
        ),
        AppSpacing.extraSmallHeight,
        // SizedBox(height: screen.height * 0.01),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.textSize11.copyWith(fontWeight: FontWeight.w800, color: Colors.black87.withOpacity(0.8)),
        ),
      ],
    );
  }
}
