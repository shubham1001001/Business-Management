import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  final List<Map<String, String>> _balanceData = [
    {'label': 'Cash', 'amount': '10K', 'icon': 'assets/svg_icons/cash_icon.svg'},
    {'label': 'Bank', 'amount': '100K', 'icon': 'assets/svg_icons/bank_icon.svg'},
    {'label': 'Receivable', 'amount': '10000', 'icon': 'assets/svg_icons/receivable_icon.svg'},
    {'label': 'Payable', 'amount': '20000', 'icon': 'assets/svg_icons/payable.svg'},
  ];

  List<Map<String, String>> get balanceData => _balanceData;
}
