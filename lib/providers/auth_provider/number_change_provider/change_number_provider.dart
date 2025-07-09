import 'package:flutter/material.dart';

class ChangeNumberProvider extends ChangeNotifier {
  String phone = '';
  String countryCode = '+91';

  void updatePhone(String value) {
    phone = value;
    notifyListeners();
  }

  void updateCountryCode(String code) {
    countryCode = code;
    notifyListeners();
  }
}
