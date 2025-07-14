class PurchaseBillOverviewModel {
  final String customerName;
  final int totalAmount;
  final int balance;
  final String status;
  final DateTime date;

  PurchaseBillOverviewModel({required this.customerName, required this.totalAmount, required this.balance, required this.status, required this.date});
}
