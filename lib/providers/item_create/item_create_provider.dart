// lib/providers/item_form_provider.dart
import 'package:flutter/material.dart';

class ItemCreateProvider extends ChangeNotifier {
  bool isProduct = true;
  bool isValid = false;

  final itemNameController = TextEditingController();
  String? unit;
  String? salesAccount;
  String? purchaseAccount;
  String itemName = '';

  String? itemNameError = 'Item name is required';
  String? _selectedUnit;
  final List<String> itemSelect = ['Warehouse 1', 'Warehouse 2', 'Warehouse 3', 'Warehouse 4', 'Warehouse 5', 'Warehouse 6', 'Warehouse 7', 'Warehouse 8'];

  String? get selectedUnit => _selectedUnit;
  List<String> get units => itemSelect;

  String? selectedSalesAccount;
  String? selectedPurchaseAccount;

  void setSelectedSalesAccount(String value) {
    selectedSalesAccount = value;
    notifyListeners();
  }

  void setSelectedPurchaseAccount(String value) {
    selectedPurchaseAccount = value;
    notifyListeners();
  }

  void setItemName(String value) {
    itemName = value;
    notifyListeners();
  }

  void setSelectedUnit(String unit) {
    _selectedUnit = unit;
    notifyListeners();
  }

  void setType(bool product) {
    isProduct = product;
    notifyListeners();
  }

  void setUnit(String? value) {
    unit = value;
    notifyListeners();
  }

  void setSalesAccount(String? value) {
    salesAccount = value;
    notifyListeners();
  }

  void setPurchaseAccount(String? value) {
    purchaseAccount = value;
    notifyListeners();
  }

  bool validateForm(value) {
    itemNameError = null;

    if (value.trim().isEmpty) {
      isValid = false;
      itemNameError = 'Item name is required';
    } else if (value.trim().toString().isNotEmpty) {
      isValid = true;
    }

    notifyListeners();
    return itemNameError == null;
  }

  void clearForm() {
    itemNameController.clear();
    unit = null;
    salesAccount = null;
    purchaseAccount = null;
    notifyListeners();
  }

  void submitForm() {}
}
