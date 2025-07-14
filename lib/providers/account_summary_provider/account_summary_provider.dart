import 'package:flutter/material.dart';

import '../../models/account_summry_model.dart';

class AccountSummaryProvider extends ChangeNotifier {
  final assets = [AccountSummaryItem(title: 'Current assets', debit: 1000, credit: 0), AccountSummaryItem(title: 'Fixed assets', debit: 100, credit: 0)];

  final liabilities = [AccountSummaryItem(title: 'Lorem ipsum', debit: 0, credit: 250), AccountSummaryItem(title: 'Current liabilities', debit: 0, credit: 3000)];

  final income = [AccountSummaryItem(title: 'Direct income', debit: 0, credit: 150), AccountSummaryItem(title: 'Indirect income', debit: 0, credit: 5000)];
}
