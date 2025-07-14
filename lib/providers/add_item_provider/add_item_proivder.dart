import 'package:flutter/material.dart';

class AddItemProvider extends ChangeNotifier {
  String itemName = '';
  double quantity = 0;
  double pricePerUnit = 0;
  String unit = 'nos';

  double get total => quantity * pricePerUnit;

  void updateItemName(String value) {
    itemName = value;
    notifyListeners();
  }

  void updateQuantity(String value) {
    quantity = double.tryParse(value) ?? 0;
    notifyListeners();
  }

  void updatePrice(String value) {
    pricePerUnit = double.tryParse(value) ?? 0;
    notifyListeners();
  }

  void updateUnit(String value) {
    unit = value;
    notifyListeners();
  }
}
