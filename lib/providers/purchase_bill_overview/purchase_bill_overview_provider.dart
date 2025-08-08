import 'package:flutter/material.dart';

import '../../models/purchase_bill_overview_model.dart';

class PurchaseBillOverviewProvider with ChangeNotifier {
  String filter = 'All';

  final List<PurchaseBillOverviewModel> _orders = [
    PurchaseBillOverviewModel(customerName: 'Balan KP', totalAmount: 100250, balance: 33002, status: 'Recently', date: DateTime(2025, 2, 12)), //
    PurchaseBillOverviewModel(customerName: 'Balan KP', totalAmount: 1000, balance: 33002, status: 'Date', date: DateTime(2025, 2, 12)),
  ];

  List<PurchaseBillOverviewModel> get filteredOrders {
    if (filter == 'All') return _orders;
    return _orders.where((order) => order.status == filter).toList();
  }

  void setFilter(String status) {
    filter = status;
    notifyListeners();
  }
}
