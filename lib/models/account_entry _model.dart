// models/account_entry.dart
class AccountEntry {
  final String name;
  final double debit;
  final double credit;

  AccountEntry({required this.name, required this.debit, required this.credit});

  factory AccountEntry.fromJson(Map<String, dynamic> json) {
    return AccountEntry(name: json['name'], debit: (json['debit'] ?? 0).toDouble(), credit: (json['credit'] ?? 0).toDouble());
  }
}
