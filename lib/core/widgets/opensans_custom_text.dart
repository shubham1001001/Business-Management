import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenSansCustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const OpenSansCustomText({super.key, required this.text, this.color = Colors.black, this.fontSize = 16, this.fontWeight = FontWeight.w600, this.textAlign, this.maxLines, this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
      ),
    );
  }
}
