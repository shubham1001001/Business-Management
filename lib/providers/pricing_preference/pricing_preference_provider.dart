import 'package:flutter/material.dart';

class PricingPreferenceProvider with ChangeNotifier {
  String? selectedVendor;
  String selectedUnit = 'Unit';
  DateTime? selectedDate;
  String sellingPrice = 'INR 1000 - once inputted';
  String purchasePrice = 'INR';
  String openingQty = 'Qty';

  void selectVendor(String vendor) {
    selectedVendor = vendor;
    notifyListeners();
  }

  void selectUnit(String unit) {
    selectedUnit = unit;
    notifyListeners();
  }

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void setSellingPrice(String value) {
    sellingPrice = value;
    notifyListeners();
  }

  void setPurchasePrice(String value) {
    purchasePrice = value;
    notifyListeners();
  }

  void setQty(String value) {
    openingQty = value;
    notifyListeners();
  }

  void submitForm() {}
}
