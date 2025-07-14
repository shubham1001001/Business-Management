// lib/providers/tab_provider.dart
import 'package:flutter/material.dart';

class TabProvider extends ChangeNotifier {
  int _currentIndex = 0;
  String _currentTab = 'Home';

  int get currentIndex => _currentIndex;
  String get currentTab => _currentTab;

  void changeTab(int index, BuildContext context, VoidCallback showGenerateSheet) {
    const tabs = ['Home', 'Report', 'Generate', 'Record', 'More'];
    _currentTab = tabs[index];

    if (index == 2) {
      showGenerateSheet();
      return;
    }

    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}
