import 'package:flutter/material.dart';

import '../models/record_selections_model.dart';

enum FilterDropItem { today, thisWeek, thisMonth, lastMonth }

class RecordProvider extends ChangeNotifier {
  String _selectedTab = 'Sales';
  String _selectedSubFilter = 'All';
  FilterDropItem selectedFilter = FilterDropItem.today;
  var dropItem = [DropdownMenuItem(value: FilterDropItem.today, child: Text("Today")), DropdownMenuItem(value: FilterDropItem.thisWeek, child: Text("This Week")), DropdownMenuItem(value: FilterDropItem.thisMonth, child: Text("This Month"))];

  List<RecordSection> _listItems = [];
  late List<RecordSection> dropItemSelect;

  String get selectedTab => _selectedTab;
  String get selectedSubFilter => _selectedSubFilter;

  List<RecordSection> get listItems => _listItems;

  void setSelectedTab(String tab) {
    _selectedTab = tab;
    _selectedSubFilter = 'All';
    // Load initial data for selected tab
    selectedFilter = FilterDropItem.today;

    // Update dropdown items if needed per tab
    if (tab == "Sales") {
      dropItem = [DropdownMenuItem(value: FilterDropItem.today, child: Text("Today")), DropdownMenuItem(value: FilterDropItem.thisWeek, child: Text("This Week")), DropdownMenuItem(value: FilterDropItem.thisMonth, child: Text("This Month"))];
    } else if (tab == "Purchase") {
      dropItem = [DropdownMenuItem(value: FilterDropItem.today, child: Text("Today")), DropdownMenuItem(value: FilterDropItem.thisWeek, child: Text("This Week")), DropdownMenuItem(value: FilterDropItem.thisMonth, child: Text("This Month"))];
    } else {
      dropItem = [DropdownMenuItem(value: FilterDropItem.today, child: Text("Today")), DropdownMenuItem(value: FilterDropItem.thisWeek, child: Text("This Week")), DropdownMenuItem(value: FilterDropItem.thisMonth, child: Text("This Month"))];
    }
    _updateBaseData();
    notifyListeners();
  }

  void setSubFilter(String filter) {
    _selectedSubFilter = filter;
    _applyTextFilter();
    notifyListeners();
  }

  void setFilter(FilterDropItem filter) {
    selectedFilter = filter;
    _applyDateFilter(); // Apply date-based filter
    // _applyTextFilter(); // Apply subfilter after that
    notifyListeners();
  }

  void _updateBaseData() {
    List<RecordSection> allItems = [];

    if (_selectedTab == 'Bank') {
      allItems = [RecordSection(date: "26.07.2025", title: "No data", count: 136, icon: "assets/svg_icons/b_doller.svg"), RecordSection(date: "15.07.2025", title: "lorem", count: 100, icon: "assets/svg_icons/b_doller.svg"), RecordSection(date: "15.07.2025", title: "lorem", count: 90, icon: "assets/svg_icons/b_doller.svg")];
      setFilter(selectedFilter);
    } else if (_selectedTab == 'Cash') {
      allItems = List.generate(7, (_) => RecordSection(date: "25.07.2025", title: "Petty Cash", count: 10, icon: "assets/svg_icons/rupee_icon.svg"));
      setFilter(selectedFilter);
    } else if (_selectedTab == 'Expenses') {
      allItems = [RecordSection(date: "25.07.2025", title: "Lorem ipsum 1", count: 12, icon: "assets/svg_icons/expenses_item_icon.svg"), RecordSection(date: "25.07.2025", title: "Lorem ipsum 22", count: 90, icon: "assets/svg_icons/expenses_item_icon.svg"), RecordSection(date: "25.07.2025", title: "Lorem ipsum 33", count: 90, icon: "assets/svg_icons/expenses_item_icon.svg"), RecordSection(date: "25.07.2025", title: "Lorem ipsum", count: 90, icon: "assets/svg_icons/expenses_item_icon.svg")];
    }

    dropItemSelect = allItems;
    _applyDateFilter();
    _applyTextFilter();
  }

  void _applyDateFilter() {
    if (dropItemSelect == null || dropItemSelect!.isEmpty) {
      _listItems = [];
      return;
    }

    final now = DateTime.now();
    _listItems = dropItemSelect!.where((tx) {
      if (tx.date == null) return true;

      final txDate = _parseDate(tx.date!);
      switch (selectedFilter) {
        case FilterDropItem.today:
          return txDate.day == now.day && txDate.month == now.month && txDate.year == now.year;
        case FilterDropItem.thisWeek:
          final weekAgo = now.subtract(const Duration(days: 7));
          return txDate.isAfter(weekAgo);
        case FilterDropItem.thisMonth:
          return txDate.month == now.month && txDate.year == now.year;
        case FilterDropItem.lastMonth:
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    }).toList();
  }

  void _applyTextFilter() {
    if (_selectedSubFilter == 'All') return;

    _listItems = _listItems.where((item) => item.title.toLowerCase().contains(_selectedSubFilter.toLowerCase())).toList();
  }

  List<RecordSection> get overviewItems {
    switch (_selectedTab) {
      case 'Sales':
        return [RecordSection(title: "Sales Order", count: 135, icon: "assets/svg_icons/sales_order_icon.svg"), RecordSection(title: "Sales Invoice", count: 155, icon: "assets/svg_icons/sales_invoice_icon.svg"), RecordSection(title: "Sales Return", count: 15, icon: "assets/svg_icons/sales_return_icon.svg"), RecordSection(title: "Receipt", count: 1305, icon: "assets/svg_icons/receipt.svg")];
      case 'Purchase':
        return [RecordSection(title: "Purchase Order", count: 50, icon: "assets/svg_icons/sales_order_icon.svg"), RecordSection(title: "Bill", count: 120, icon: "assets/svg_icons/sales_order_icon.svg")];
      default:
        return [];
    }
  }

  List<String> get subFilters {
    if (_selectedTab == 'Bank' || _selectedTab == 'Cash' || _selectedTab == 'Expenses') {
      return ['All', 'lorem', 'lorem'];
    }
    return [];
  }

  DateTime _parseDate(String input) {
    try {
      final parts = input.split(".");
      return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    } catch (_) {
      return DateTime.now();
    }
  }
}

// enum FilterDropItem { today, thisWeek, thisMonth }
//
// class RecordProvider extends ChangeNotifier {
//   String _selectedTab = 'Sales';
//   String _selectedSubFilter = 'All';
//   List<RecordSection>? dropItemSelect;
//   String get selectedTab => _selectedTab;
//   String get selectedSubFilter => _selectedSubFilter;
//   FilterDropItem selectedFilter = FilterDropItem.today;
//
//   List<RecordSection> get listItems {
//     List<RecordSection>? allItems;
//     if (_selectedTab == 'Bank') {
//       allItems = [RecordSection(date: "15.07.2025", title: "No data", count: 136, icon: "assets/svg_icons/b_doller.svg"), RecordSection(date: "15.07.2025", title: "lorem", count: 100, icon: "assets/svg_icons/b_doller.svg"), RecordSection(date: "15.07.2025", title: "lorem", count: 90, icon: "assets/svg_icons/b_doller.svg")];
//       dropItemSelect = allItems;
//     } else if (_selectedTab == 'Cash') {
//       allItems = [RecordSection(date: "15.07.2025", title: "Petty Cash", count: 24, icon: "assets/svg_icons/rupee_icon.svg"), RecordSection(date: "15.07.2025", title: "Petty Cash", count: 24, icon: "assets/svg_icons/rupee_icon.svg"), RecordSection(date: "15.07.2025", title: "Petty Cash", count: 24, icon: "assets/svg_icons/rupee_icon.svg"), RecordSection(date: "15.07.2025", title: "Petty Cash", count: 24, icon: "assets/svg_icons/rupee_icon.svg"), RecordSection(date: "15.07.2025", title: "Petty Cash", count: 24, icon: "assets/svg_icons/rupee_icon.svg"), RecordSection(date: "15.07.2025", title: "Petty Cash", count: 24, icon: "assets/svg_icons/rupee_icon.svg"), RecordSection(date: "15.07.2025", title: "Petty Cash", count: 24, icon: "assets/svg_icons/rupee_icon.svg")];
//       dropItemSelect = allItems;
//     } else if (_selectedTab == 'Expenses') {
//       allItems = [RecordSection(title: "Office Supplies", count: 12, icon: "assets/svg_icons/expenses_item_icon.svg"), RecordSection(title: "lorem", count: 90, icon: "assets/svg_icons/expenses_item_icon.svg")];
//     } else {
//       allItems = [];
//     }
//
//     // Apply filter
//     if (_selectedSubFilter == 'All') {
//       return allItems;
//     } else {
//       return allItems.where((item) => item.title.toLowerCase().contains(_selectedSubFilter.toLowerCase())).toList();
//     }
//   }
//
//   void setFilter(FilterDropItem filter) {
//     selectedFilter = filter;
//     _applyFilter();
//     // listItems = dropItemSelect;
//     notifyListeners();
//   }
//
//   void setSelectedTab(String tab) {
//     _selectedTab = tab;
//     _selectedSubFilter = 'All';
//     notifyListeners();
//   }
//
//   void setSubFilter(String filter) {
//     _selectedSubFilter = filter;
//
//     notifyListeners();
//   }
//
//   List<RecordSection> get overviewItems {
//     switch (_selectedTab) {
//       case 'Sales':
//         return [RecordSection(title: "Sales Order", count: 135, icon: "assets/svg_icons/sales_order_icon.svg"), RecordSection(title: "Sales Invoice", count: 155, icon: "assets/svg_icons/sales_invoice_icon.svg"), RecordSection(title: "Sales Return", count: 15, icon: "assets/svg_icons/sales_return_icon.svg"), RecordSection(title: "Receipt", count: 1305, icon: "assets/svg_icons/receipt.svg")];
//       case 'Purchase':
//         return [RecordSection(title: "Purchase Order", count: 50, icon: "assets/svg_icons/sales_order_icon.svg"), RecordSection(title: "Bill", count: 120, icon: "assets/svg_icons/sales_order_icon.svg")];
//       default:
//         return [];
//     }
//   }
//
//   void _applyFilter() {
//     final now = DateTime.now();
//     dropItemSelect = dropItemSelect?.where((tx) {
//       final txDate = _parseDate(tx.date.toString());
//       switch (selectedFilter) {
//         case FilterDropItem.today:
//           return txDate.day == now.day && txDate.month == now.month && txDate.year == now.year;
//         case FilterDropItem.thisWeek:
//           final weekAgo = now.subtract(const Duration(days: 7));
//           return txDate.isAfter(weekAgo);
//         case FilterDropItem.thisMonth:
//           return txDate.month == now.month && txDate.year == now.year;
//       }
//     }).toList();
//   }
//
//   List<String> get subFilters {
//     if (_selectedTab == 'Bank' || _selectedTab == 'Cash' || _selectedTab == 'Expenses') {
//       return ['All', 'lorem'];
//     }
//     return [];
//   }
//
//   DateTime _parseDate(String input) {
//     final parts = input.split(".");
//     return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
//   }
// }
