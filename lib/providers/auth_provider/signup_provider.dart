import 'package:flutter/material.dart';

import '../../models/country_model.dart';

class AuthProvider extends ChangeNotifier {
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

  bool get isPhoneValid {
    // Accepts 10-digit mobile numbers only (India-style)
    final regex = RegExp(r'^[6-9]\d{9}$');
    return regex.hasMatch(phone);
  }

  /// List of countries (dynamic or mock)
  List<CountryModel> _countries = [];

  List<CountryModel> get countries => _countries;

  /// Simulated API fetch (replace with actual API call)
  Future<void> fetchCountries() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate delay
    _countries = [CountryModel(code: '+91', name: 'India', flag: '🇮🇳'), CountryModel(code: '+1', name: 'USA', flag: '🇺🇸'), CountryModel(code: '+44', name: 'UK', flag: '🇬🇧')];
    notifyListeners();
  }
}
