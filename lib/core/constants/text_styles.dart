import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTextStyles {
  static const title = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');
  static const titleListTile = TextStyle(fontWeight: FontWeight.w600, fontFamily: 'OpenSans');
  static const title16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'OpenSans');
  static const textSize16 = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontFamily: 'OpenSans');
  static const subtitle = TextStyle(fontSize: 14, color: Colors.black54, fontFamily: 'OpenSans');
  static final subtitleGrey = TextStyle(fontSize: 14, color: AppColors.grey100, fontFamily: 'OpenSans');
  static const small = TextStyle(fontSize: 12, fontFamily: 'OpenSans');
  static const appBarRedBoldText = TextStyle(color: AppColors.redColor, fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'OpenSans');
  static const appBarBlackBoldText = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'OpenSans');
  static const appBarRedText = TextStyle(color: AppColors.redColor, fontFamily: 'OpenSans');
  static const backText = TextStyle(color: Colors.black, fontFamily: 'OpenSans');
  static const greyText = TextStyle(fontWeight: FontWeight.w400, color: Colors.grey, fontFamily: 'OpenSans');
  static const backBoldText = TextStyle(color: AppColors.appBlackColor, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');
  static const greyBoldText = TextStyle(color: AppColors.greyText, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');
  static const greyBoldText20 = TextStyle(color: AppColors.greyText, fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'OpenSans');
  static const greyBoldW500Text = TextStyle(fontWeight: FontWeight.w500, color: AppColors.greyText, fontFamily: 'OpenSans');
  static const greyText12 = TextStyle(color: AppColors.greyText, fontSize: 12, fontFamily: 'OpenSans');
  static const greyText17 = TextStyle(color: AppColors.greyText, fontSize: 17, fontFamily: 'OpenSans');
  static const greyText20 = TextStyle(color: AppColors.greyText, fontSize: 20, fontFamily: 'OpenSans');
  static const redText = TextStyle(color: Colors.red, fontFamily: 'OpenSans');
  static const appRedText = TextStyle(color: AppColors.redColor, fontFamily: 'OpenSans');
  static const appRedBoldText = TextStyle(color: AppColors.redColor, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');
  static const appRedBoldText13 = TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.redColor, fontFamily: 'OpenSans');
  static final appLightRedBoldText = TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red.shade200, fontFamily: 'OpenSans');
  static const redBoldText = TextStyle(color: AppColors.redColor, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');
  static const textSize13 = TextStyle(fontSize: 13, fontFamily: 'OpenSans');
  static const textSize11 = TextStyle(fontSize: 11, fontFamily: 'OpenSans');
  static const white70BoldText20 = TextStyle(fontSize: 20, color: Colors.white70, fontWeight: FontWeight.w600, fontFamily: 'OpenSans');
  static const redBoldText14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.redColor, fontFamily: 'OpenSans');
  static const blackBoldText13 = TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');
  static const blackBoldText24 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');
  static const black87Text20 = TextStyle(fontSize: 20, color: Colors.black87, fontFamily: 'OpenSans');
  static const blueBoldText = TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');
  static const blueText = TextStyle(color: Colors.blue, fontFamily: 'OpenSans');
  static const white54BoldText40 = TextStyle(fontSize: 40, color: Colors.white54, fontWeight: FontWeight.w600, fontFamily: 'OpenSans');
  static const blackBoldText15 = TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'OpenSans');
  static const appRedText18 = TextStyle(color: AppColors.redColor, fontSize: 18, fontFamily: 'OpenSans');
  static const appBlackText18 = TextStyle(fontSize: 18, fontFamily: 'OpenSans');
  static const boldText = TextStyle(fontWeight: FontWeight.bold, fontFamily: 'OpenSans');
  static final headingBaskervVilleFontStyleTextBig = GoogleFonts.baskervville(fontSize: 55, color: Color(0xFF655C4A), fontWeight: FontWeight.w400);
  static final headingBaskervVilleFontStyleText = GoogleFonts.baskervville(fontSize: 35, color: Color(0xFF655C4A), fontWeight: FontWeight.w400);
  static final headingBaskervVilleFontStyleText20 = GoogleFonts.baskervville(fontSize: 20, color: Color(0xFF655C4A), fontWeight: FontWeight.w400);
  static final openSansRegular = TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black);
  static final openSansSemiBold = TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black);
  static final openSansFontStyleTextW400 = GoogleFonts.openSans(
    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
  );
  static final customButtonTextStyle = GoogleFonts.openSans(textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600));
  static final customButtonTextWhiteStyle = GoogleFonts.openSans(
    color: Colors.white,
    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );
  static final heading1FontStyleText = GoogleFonts.openSans(
    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF655C4A)),
  );
  static final robotoFontStyleText = GoogleFonts.roboto(
    textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.redColor),
  );
}
