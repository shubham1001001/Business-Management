import 'package:flutter/material.dart';

class AppSpacing {
  // Custom padding/margin presets
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
  static const EdgeInsets allPadding16 = EdgeInsets.all(16.0);
  static const EdgeInsets allPadding12 = EdgeInsets.all(12.0);
  static const EdgeInsets allPadding10 = EdgeInsets.all(10.0);
  static const EdgeInsets allPadding8 = EdgeInsets.all(8.0);
  static const EdgeInsets allPadding5 = EdgeInsets.all(5.0);
  static const EdgeInsets sectionSpacing = EdgeInsets.only(top: 24.0, bottom: 16.0);

  //BorderRadius

  static final BorderRadius kSmallRadius = BorderRadius.circular(12);
  static final BorderRadius kMediumRadius10 = BorderRadius.circular(10);
  static final BorderRadius kMediumRadius = BorderRadius.circular(8);
  static final BorderRadius kLargeRadius = BorderRadius.circular(5);
  static final BorderRadius kChipRadius = BorderRadius.circular(17);
  static final BorderRadius kRadius20 = BorderRadius.circular(20);
  static final BorderRadius kRadius25 = BorderRadius.circular(25);

  //BorderRadius

  static final Radius rMediumRadius = Radius.circular(8);
  static final Radius rMediumRadius10 = Radius.circular(10);
  static final Radius rRadius20 = Radius.circular(20);
  static final Radius rSmallRadius = Radius.circular(12);
  static final Radius rLargeRadius = Radius.circular(5);
  //height
  static const Widget extraSmallHeight = SizedBox(height: 5);
  static const Widget extraSmallWidth = SizedBox(width: 5);
  static const Widget smallHeight = SizedBox(height: 8);
  static const Widget smallWidth = SizedBox(width: 8);
  static const Widget smallHeight10 = SizedBox(height: 10);
  static const Widget smallWidth10 = SizedBox(width: 10);
  static const Widget mediumHeight = SizedBox(height: 20);
  static const Widget mediumWidth = SizedBox(width: 20);
  static const Widget mediumHeight16 = SizedBox(height: 16);
  static const Widget mediumWidth16 = SizedBox(width: 16);
  static const Widget largeHeight = SizedBox(height: 25);
  static const Widget largeWidth = SizedBox(width: 25);
  static const Widget largeHeight40 = SizedBox(height: 40);
  static const Widget largeWidth40 = SizedBox(width: 40);
}
