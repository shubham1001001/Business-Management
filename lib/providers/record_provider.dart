import 'package:flutter/material.dart';

import '../models/record_selections_model.dart';

class RecordProvider extends ChangeNotifier {
  String _selectedTab = 'Sales';
  String _selectedSubFilter = 'All';

  String get selectedTab => _selectedTab;
  String get selectedSubFilter => _selectedSubFilter;

  List<RecordSection> get listItems {
    List<RecordSection> allItems;

    if (_selectedTab == 'Bank') {
      allItems = [RecordSection(title: "No data", count: 136, icon: Icons.insert_drive_file), RecordSection(title: "lorem", count: 100, icon: Icons.insert_drive_file), RecordSection(title: "lorem", count: 90, icon: Icons.insert_drive_file)];
    } else if (_selectedTab == 'Cash') {
      allItems = [RecordSection(title: "Petty Cash", count: 24, icon: Icons.money), RecordSection(title: "Petty Cash", count: 24, icon: Icons.money), RecordSection(title: "Petty Cash", count: 24, icon: Icons.money), RecordSection(title: "Petty Cash", count: 24, icon: Icons.money), RecordSection(title: "Petty Cash", count: 24, icon: Icons.money), RecordSection(title: "Petty Cash", count: 24, icon: Icons.money), RecordSection(title: "Petty Cash", count: 24, icon: Icons.money), RecordSection(title: "Petty Cash", count: 24, icon: Icons.money), RecordSection(title: "lorem", count: 90, icon: Icons.insert_drive_file), RecordSection(title: "lorem", count: 90, icon: Icons.insert_drive_file), RecordSection(title: "lorem", count: 90, icon: Icons.insert_drive_file)];
    } else if (_selectedTab == 'Expenses') {
      allItems = [RecordSection(title: "Office Supplies", count: 12, icon: Icons.description), RecordSection(title: "lorem", count: 90, icon: Icons.insert_drive_file)];
    } else {
      allItems = [];
    }

    // Apply filter
    if (_selectedSubFilter == 'All') {
      return allItems;
    } else {
      return allItems.where((item) => item.title.toLowerCase().contains(_selectedSubFilter.toLowerCase())).toList();
    }
  }

  void setSelectedTab(String tab) {
    _selectedTab = tab;
    _selectedSubFilter = 'All';
    notifyListeners();
  }

  void setSubFilter(String filter) {
    _selectedSubFilter = filter;

    notifyListeners();
  }

  List<RecordSection> get overviewItems {
    switch (_selectedTab) {
      case 'Sales':
        return [
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),

          RecordSection(title: "Sales Invoice", count: 155, icon: Icons.receipt_long),
          RecordSection(title: "Sales Return", count: 15, icon: Icons.undo),
          RecordSection(title: "Receipt", count: 1305, icon: Icons.assignment_turned_in),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
          RecordSection(title: "Sales Order", count: 135, icon: Icons.receipt),
        ];
      case 'Purchase':
        return [RecordSection(title: "Purchase Order", count: 50, icon: Icons.shopping_cart), RecordSection(title: "Bill", count: 120, icon: Icons.receipt_long)];
      default:
        return [];
    }
  }

  List<String> get subFilters {
    if (_selectedTab == 'Bank' || _selectedTab == 'Cash' || _selectedTab == 'Expenses') {
      return ['All', 'lorem'];
    }
    return [];
  }
}
