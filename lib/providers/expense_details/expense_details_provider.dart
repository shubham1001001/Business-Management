import 'package:flutter/cupertino.dart';

import '../../models/expence_detail_item.dart';

class ExpenseDetailProvider extends ChangeNotifier {
  final List<ExpenseItem> _items = [ExpenseItem(name: 'Item name 1', amount: 75), ExpenseItem(name: 'Item name 2', amount: 75)];

  List<ExpenseItem> get items => _items;
  double get totalAmount => _items.fold(0.0, (sum, item) => sum + item.amount);
}
