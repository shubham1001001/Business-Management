import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomAuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double height;
  final double width;
  final double borderRadius;

  const CustomAuthButton({super.key, required this.text, required this.onTap, this.height = 39, this.width = 175, this.borderRadius = 8});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(color: AppColors.redColor, borderRadius: BorderRadius.circular(borderRadius)),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
