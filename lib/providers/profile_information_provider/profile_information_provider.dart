import 'package:flutter/material.dart';

class ProfileInformationProvider with ChangeNotifier {
  bool isEditingFirstName = false;
  bool isEditingMobile = false;
  bool isEditingEmail = false;
  String phone = '';
  String email = '';
  String? emailError;
  void toggleFirstNameEditing() {
    isEditingFirstName = !isEditingFirstName;
    isEditingMobile = !isEditingMobile;
    isEditingEmail = !isEditingEmail;
    notifyListeners();
  }

  void toggleMobileEditing() {
    isEditingMobile = !isEditingMobile;
    notifyListeners();
  }

  void updatePhone(String value) {
    print(value);
    phone = value;
    notifyListeners();
  }

  bool get isPhoneValid {
    // Accepts 10-digit mobile numbers only (India-style)
    final regex = RegExp(r'^[6-9]\d{9}$');
    return regex.hasMatch(phone);
  }

  void updateEmail(String value) {
    print(value);
    email = value;
    emailError = _validateEmail(value);
    notifyListeners();
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) return 'Enter a valid email address';
    return null;
  }

  void toggleEmailEditing() {
    isEditingEmail = !isEditingEmail;
    notifyListeners();
  }
}
