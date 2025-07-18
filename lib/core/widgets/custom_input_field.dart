import 'package:flutter/material.dart';

import '../constants/text_styles.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String hintText;
  final String? prefixText;
  final String? errorText;
  final bool isRequired;
  final ValueChanged<String> onChanged;
  final bool isEditable;
  final int? maxLines;
  const CustomInputField({Key? key, this.controller, required this.keyboardType, required this.hintText, this.prefixText, this.errorText, this.isRequired = false, required this.onChanged, required this.isEditable, this.maxLines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      enabled: isEditable,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: AppTextStyles.greyText,
        hintText: isRequired ? "$hintText" : hintText,
        prefix: Text(prefixText ?? 'test', style: TextStyle(color: Colors.black)),
        errorText: errorText,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
