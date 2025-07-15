import 'package:flutter/material.dart';

import '../models/account_transaction_model.dart';

enum TransactionFilter { today, thisWeek, thisMonth, custom }

class AccountDetailsProvider with ChangeNotifier {
  bool isLoading = true;
  List<AccountTransaction> _allTransactions = [];
  List<AccountTransaction> filteredTransactions = [];
  double balanceAmount = 0;
  TransactionFilter selectedFilter = TransactionFilter.today;
  DateTime? customFromDate;
  DateTime? customToDate;

  Future<void> fetchAccountDetails() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2)); // simulate API

    final response = {
      "balance": 250000.0,
      "transactions": [
        {"name": "Lorem ipsum", "debit": 125, "credit": 0, "date": "15.07.2025"},
        {"name": "Lorem ipsum", "debit": 125, "credit": 0, "date": "12.07.2025"},
        {"name": "Lorem ipsum", "debit": 100, "credit": 0, "date": "12.07.2025"},
        {"name": "Lorem ipsum", "debit": 25, "credit": 0, "date": "11.07.2025"},
      ],
    };

    balanceAmount = double.parse(response['balance'].toString());
    _allTransactions = (response['transactions'] as List).map((e) => AccountTransaction.fromJson(e)).toList();

    _applyFilter(); // apply current filter
    isLoading = false;
    notifyListeners();
  }

  void setFilter(TransactionFilter filter) {
    selectedFilter = filter;
    _applyFilter();
    notifyListeners();
  }

  void setCustomRange(DateTime from, DateTime to) {
    customFromDate = from;
    customToDate = to;
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    final now = DateTime.now();
    filteredTransactions = _allTransactions.where((tx) {
      final txDate = _parseDate(tx.date);
      switch (selectedFilter) {
        case TransactionFilter.today:
          return txDate.day == now.day && txDate.month == now.month && txDate.year == now.year;
        case TransactionFilter.thisWeek:
          final weekAgo = now.subtract(const Duration(days: 7));
          return txDate.isAfter(weekAgo);
        case TransactionFilter.thisMonth:
          return txDate.month == now.month && txDate.year == now.year;
        case TransactionFilter.custom:
          if (customFromDate == null || customToDate == null) return false;
          return txDate.isAtSameMomentAs(customFromDate!) || txDate.isAtSameMomentAs(customToDate!) || (txDate.isAfter(customFromDate!) && txDate.isBefore(customToDate!));
      }
    }).toList();
  }

  void deleteAccount() {
    // Add your deletion logic here
    debugPrint("Account deleted"); // or API call
  }

  double get totalDebit => filteredTransactions.fold(0.0, (sum, e) => sum + e.debit);
  double get totalCredit => filteredTransactions.fold(0.0, (sum, e) => sum + e.credit);

  DateTime _parseDate(String input) {
    final parts = input.split(".");
    return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }
}
