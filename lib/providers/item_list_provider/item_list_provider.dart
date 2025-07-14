import 'package:flutter/material.dart';

import '../../models/item_list_model.dart';

class ItemListProvider with ChangeNotifier {
  String filter = 'All';

  final List<ItemListModel> _orders = [
    ItemListModel(customerName: 'Oil', description: "120L", status: 'Goods', date: DateTime(2025, 2, 12)), //
    ItemListModel(customerName: 'Empty bottle', description: "420 carton box", status: 'Goods', date: DateTime(2025, 2, 12)),
    ItemListModel(customerName: 'Plain perforated paper', description: "200 crate", status: 'Service', date: DateTime(2025, 2, 12)),
    ItemListModel(customerName: 'Hand wash', description: "350 bottle", status: 'Service', date: DateTime(2025, 2, 12)),
    ItemListModel(customerName: 'Drawing pencil', description: "200 box", status: 'Service', date: DateTime(2025, 2, 12)),
    ItemListModel(customerName: 'A3 sheet - matte', description: "300 box", status: 'Service', date: DateTime(2025, 2, 12)),
  ];

  List<ItemListModel> get filteredOrders {
    if (filter == 'All') return _orders;
    return _orders.where((order) => order.status == filter).toList();
  }

  void setFilter(String status) {
    filter = status;
    notifyListeners();
  }
}
