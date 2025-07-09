import 'package:flutter/material.dart';

import '../models/sales_order_model.dart';

class SalesOrderProvider with ChangeNotifier {
  String filter = 'All';

  final List<SalesOrder> _orders = [
    SalesOrder(customerName: 'Balan KP', totalAmount: 100250, balance: 33002, status: 'Draft', date: DateTime(2025, 2, 12)), //
    SalesOrder(customerName: 'Balan KP', totalAmount: 1000, balance: 100, status: 'Sold', date: DateTime(2025, 2, 12)),
    SalesOrder(customerName: 'Balan KP', totalAmount: 1000, balance: 350, status: 'Pending', date: DateTime(2025, 2, 12)),
    SalesOrder(customerName: 'Balan KP', totalAmount: 1000, balance: 570, status: 'Closed', date: DateTime(2025, 2, 12)),
    SalesOrder(customerName: 'Balan KP', totalAmount: 1000, balance: 2770, status: 'Closed', date: DateTime(2025, 2, 12)),
  ];

  List<SalesOrder> get filteredOrders {
    if (filter == 'All') return _orders;
    return _orders.where((order) => order.status == filter).toList();
  }

  void setFilter(String status) {
    filter = status;
    notifyListeners();
  }
}
