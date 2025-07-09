import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class GenerateCart extends StatelessWidget {
  final String icon;
  final String label;

  const GenerateCart({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: screen.width * 0.12,
          height: screen.height * 0.10,
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon, width: screen.width * 0.07),
              SizedBox(height: 6),
            ],
          ),
        ),
        SizedBox(height: 3),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
