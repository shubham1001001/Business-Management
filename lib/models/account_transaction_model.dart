class AccountTransaction {
  final String name;
  final double debit;
  final double credit;
  final String date;

  AccountTransaction({required this.name, required this.debit, required this.credit, required this.date});

  factory AccountTransaction.fromJson(Map<String, dynamic> json) {
    return AccountTransaction(name: json['name'], debit: (json['debit'] ?? 0).toDouble(), credit: (json['credit'] ?? 0).toDouble(), date: json['date']);
  }
}
