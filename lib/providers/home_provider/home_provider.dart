import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  final List<Map<String, String>> _balanceData = [
    {'label': 'Cash', 'amount': '₹ 10K', 'icon': 'assets/icons/cash.png'},
    {'label': 'Bank', 'amount': '₹ 100K', 'icon': 'assets/icons/bank.png'},
    {'label': 'Receivable', 'amount': '₹ 10000', 'icon': 'assets/icons/receivable.png'},
    {'label': 'Payable', 'amount': '₹ 20000', 'icon': 'assets/icons/payable.png'},
  ];

  List<Map<String, String>> get balanceData => _balanceData;
}
