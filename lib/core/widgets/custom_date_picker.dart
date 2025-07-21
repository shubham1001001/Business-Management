import 'package:flutter/material.dart';

import '../constants/colors.dart';
// Adjust import as needed

class CustomDatePicker {
  static Future<DateTime?> show({required BuildContext context, required DateTime initialDate, required DateTime firstDate, required DateTime lastDate}) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.redColor, onPrimary: Colors.white, onSurface: Colors.black),
            textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: AppColors.redColor)),
          ),
          child: child!,
        );
      },
    );
  }
}
