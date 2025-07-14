import 'package:flutter/material.dart';
import 'package:sales/core/constants/text_styles.dart';

import '../../../core/constants/colors.dart';

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
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // width: isLandscape ? screen.width * 0.3 : screen.width * 0.14,
          // height: isLandscape ? screen.height * 0.5 : screen.height * 0.08,
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 0))],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(icon), // width: screen.width * 0.07
                // SizedBox(height: screen.height * 0.001),
              ],
            ),
          ),
        ),
        // SizedBox(height: screen.height * 0.002),
        Text(label, textAlign: TextAlign.center, style: AppTextStyles.textSize11),
      ],
    );
  }
}
