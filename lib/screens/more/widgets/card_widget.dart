import 'package:flutter/material.dart';
import 'package:sales/core/constants/spacing.dart';

import '../../../core/constants/colors.dart';

class CardWidget extends StatelessWidget {
  final List<Widget> child;

  CardWidget({Key? key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: AppColors.cardmainColor,
        child: Padding(
          padding: AppSpacing.allPadding10,
          child: SizedBox(
            width: 361,
            child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [...child]),
          ),
        ),
      ),
    );
  }
}
