import 'package:flutter/material.dart';

import '../constants/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double widthFactor;
  final double verticalPadding;
  final VoidCallback onPressed;
  final Color colors;

  const CustomButton({Key? key, required this.text, required this.onPressed, this.widthFactor = 0.45, this.verticalPadding = 16, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        width: size.width * widthFactor,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            textStyle: AppTextStyles.customButtonTextStyle,
            backgroundColor: colors,
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
