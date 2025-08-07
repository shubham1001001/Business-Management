import 'package:flutter/material.dart';
import 'package:sales/core/constants/colors.dart';
import 'package:sales/core/constants/spacing.dart';

import '../constants/text_styles.dart';

class CustomeTextField2 extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String hintText;
  final String? prefixText;
  final String? errorText;
  final bool isRequired;
  final ValueChanged<String> onChanged;
  final bool isEditable;
  final int? maxLines;
  const CustomeTextField2({Key? key, this.controller, required this.keyboardType, required this.hintText, this.prefixText, this.errorText, this.isRequired = false, required this.onChanged, required this.isEditable, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      maxLines: maxLines,
      enabled: isEditable,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: AppTextStyles.greyText.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
        hintText: isRequired ? "$hintText" : hintText,
        prefix: Text(prefixText ?? 'test', style: const TextStyle(color: Colors.black)),
        errorText: errorText,
        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.textFieldBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.textFieldBorderColor, width: 1.5),
        ),
        border: OutlineInputBorder(borderRadius: AppSpacing.kMediumRadius),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
