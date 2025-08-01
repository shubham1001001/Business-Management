import 'package:flutter/material.dart';
import 'package:sales/core/constants/spacing.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/svg_picture_widgets.dart';
import '../../../core/widgets/text_scale_widgets.dart';

class QuickLink extends StatelessWidget {
  final String icon;
  final String label;

  const QuickLink({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final isLandscape = screen.width > screen.height;
    return Padding(
      padding: AppSpacing.allPadding5,
      child: Container(
        width: screen.width * 0.25,
        // height: isLandscape ? screen.height * 0.35 : screen.height * 0.10,
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: AppSpacing.kMediumRadius10,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
        ),
        child: Padding(
          padding: AppSpacing.allPadding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPictureWidgets(svgString: icon, size: 40.0),
              SizedBox(height: screen.height * 0.03),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: TextScaleSize.textScaleFactor(context, maxTextScaleFactor: 40)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
