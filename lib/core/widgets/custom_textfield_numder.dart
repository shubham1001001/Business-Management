import 'package:flutter/material.dart';

class MobileNumberField extends StatelessWidget {
  final TextEditingController? controller;
  final String countryCode;
  final String hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const MobileNumberField({Key? key, this.controller, this.countryCode = '+91', this.hintText = 'Mobile number', this.errorText, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        errorText: errorText,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                countryCode,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8),
              Container(width: 1, height: 30, color: Colors.black),
            ],
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
    );
  }
}
