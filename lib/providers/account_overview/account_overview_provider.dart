import 'package:flutter/material.dart';

import '../../models/account_entry _model.dart';

class AccountOverviewProvider with ChangeNotifier {
  bool isLoading = true;
  Map<String, List<AccountEntry>> categorizedData = {};

  Future<void> fetchAccountData() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    // Simulated API response
    final Map<String, dynamic> data = {
      "data": {
        "Current assets": [
          {"name": "Lorem ipsum", "debit": 250, "credit": 0},
          {"name": "Lorem ipsum", "debit": 250, "credit": 0},
          {"name": "Lorem ipsum", "debit": 500, "credit": 0},
        ],
        "Fixed assets": [
          {"name": "Lorem ipsum", "debit": 50, "credit": 0},
          {"name": "Lorem ipsum", "debit": 50, "credit": 0},
          {"name": "Lorem ipsum", "debit": 50, "credit": 0},
        ],
      },
    };

    try {
      final Map<String, dynamic> raw = data['data']; // ✅ fix here

      final parsed = raw.map((category, entries) {
        return MapEntry(category, (entries as List).map((e) => AccountEntry.fromJson(e)).toList());
      });

      categorizedData = parsed;
    } catch (e) {
      debugPrint("Error fetching account data: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  double get totalDebit => categorizedData.values.expand((e) => e).fold(0.0, (sum, entry) => sum + entry.debit);

  double get totalCredit => categorizedData.values.expand((e) => e).fold(0.0, (sum, entry) => sum + entry.credit);
}
