import 'package:flutter/material.dart';

class EmailProvider with ChangeNotifier {
  String _email = '';
  String? _emailError;

  String get email => _email;
  String? get emailError => _emailError;

  void updateEmail(String value) {
    _email = value;
    _emailError = _validateEmail(value);
    notifyListeners();
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) return 'Enter a valid email address';
    return null;
  }
}
