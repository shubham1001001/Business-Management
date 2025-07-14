import 'package:flutter/material.dart';

import '../../models/vender_list_model.dart';

class VenderListProvider with ChangeNotifier {
  String filter = 'All';

  final List<VenderListModel> _orders = [
    VenderListModel(customerName: 'Vendor name', description: "payment terms", balance: 1800, status: 'Data', date: DateTime(2025, 2, 12)), //
    VenderListModel(customerName: 'Vendor name', description: "payment terms", balance: 1800, status: 'Data', date: DateTime(2025, 2, 12)),
    VenderListModel(customerName: 'Vendor name ', description: "payment terms", balance: 1800, status: 'No data', date: DateTime(2025, 2, 12)),
    VenderListModel(customerName: 'Vendor name', description: "payment terms", balance: 1800, status: 'data', date: DateTime(2025, 2, 12)),
    VenderListModel(customerName: 'Vendor name ', description: "payment terms", balance: 1800, status: 'data', date: DateTime(2025, 2, 12)),
  ];

  List<VenderListModel> get filteredOrders {
    if (filter == 'All') return _orders;
    return _orders.where((order) => order.status == filter).toList();
  }

  void setFilter(String status) {
    filter = status;
    notifyListeners();
  }
}
