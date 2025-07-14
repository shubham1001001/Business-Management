import 'package:flutter/material.dart';

class SubscriptionPlanProvider with ChangeNotifier {
  bool isActive = true;
  String companyName = 'NPL studio and sounds';
  String companyId = '850002';
  String planName = 'Premium 32 bit';
  String billingCycle = 'Monthly';
  String createdOn = '12.02.2025';
  String renewalOn = '11.03.2025';
  int daysLeft = 10;
}
