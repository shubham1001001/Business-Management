import 'package:flutter/material.dart';
import 'package:sales/core/constants/text_styles.dart';

<<<<<<< Updated upstream
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
=======
import '../../../core/widgets/custom_decorations.dart';
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
          // width: isLandscape ? screen.width * 0.3 : screen.width * 0.14,
          // height: isLandscape ? screen.height * 0.5 : screen.height * 0.08,
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
          ),
          child: Padding(
            padding: AppSpacing.allPadding8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(icon), // width: screen.width * 0.07
                // SizedBox(height: screen.height * 0.001),
              ],
            ),
=======
          width: isLandscape ? screen.width * 0.07 : screen.width * 0.12,
          height: isLandscape ? screen.width * 0.07 : screen.width * 0.12,
          decoration: CustomDecorations.cardBoxDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon, fit: BoxFit.fitWidth), //
            ],
>>>>>>> Stashed changes
          ),
        ),
        SizedBox(height: screen.height * 0.01),
        Text(label, textAlign: TextAlign.center, style: AppTextStyles.textSize11),
      ],
    );
  }
}
