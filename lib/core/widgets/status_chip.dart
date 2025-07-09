import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class StatusChip extends StatelessWidget {
  final String status;
  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color = status == "Draft" ? AppColors.draft : AppColors.sold;
    return Text(
      status,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }
}
