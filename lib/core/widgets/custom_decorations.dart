// lib/theme/custom_decorations.dart

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomDecorations {
  static BoxDecoration cardBoxDecoration = BoxDecoration(
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
  );
}
