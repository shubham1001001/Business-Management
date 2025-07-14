import 'package:flutter/material.dart';

class GenerateProvider extends ChangeNotifier {
  String? selected;

  void select(String item, BuildContext context) {
    selected = item;
    notifyListeners();
  }
}
