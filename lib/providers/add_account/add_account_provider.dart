import 'package:flutter/material.dart';

class AddAccountProvider extends ChangeNotifier {
  final accountNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final openingBalanceController = TextEditingController();

  String? _accountType;
  // String? get accountType => _accountType;

  List<String> _accountTypeList = [];
  String? _selectedAccountType;

  List<String> get accountTypeList => _accountTypeList;
  String? get accountType => _selectedAccountType;

  void setAccountType(String? value) {
    _selectedAccountType = value;
    notifyListeners();
  }

  Future<void> fetchAccountTypes() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    _accountTypeList = ['Account type1', 'Account type2', 'Account type3']; // Replace with API response
    notifyListeners();
  }

  bool validateForm() {
    return accountNameController.text.isNotEmpty && openingBalanceController.text.isNotEmpty;
  }

  void submitForm() {
    if (validateForm()) {
      debugPrint('Name: ${accountNameController.text}');
      debugPrint('Address: ${descriptionController.text}');
      debugPrint('Type: $accountType');
      debugPrint('Type: $accountType');
    } else {
      debugPrint('Validation failed');
    }
  }
}
