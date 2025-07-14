import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDropdownPlaceholder extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerDropdownPlaceholder({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width * 0.4,
        padding: EdgeInsets.symmetric(vertical: height * 0.008, horizontal: width * 0.03),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(), borderRadius: BorderRadius.circular(5)),
        child: Container(
          height: height * 0.05, // Approximate height of dropdown
          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}
