// tab_provider.dart
import 'package:flutter/material.dart';

class TabProvider extends ChangeNotifier {
  int _selectedTab = 0; // 0 = Dashboard, 1 = Support

  int get selectedTab => _selectedTab;

  void changeTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }
}
