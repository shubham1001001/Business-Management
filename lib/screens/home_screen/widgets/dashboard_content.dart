import 'package:flutter/material.dart';
import 'package:sales/core/constants/colors.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          // Top Balance Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              BalanceCard(label: "Cash", amount: "₹ 10K", icon: "assets/icons/cash.png"),
              BalanceCard(label: "Bank", amount: "₹ 100K", icon: "assets/icons/bank.png"),
              BalanceCard(label: "Receivable", amount: "₹ 10000", icon: "assets/icons/receivable.png"),
              BalanceCard(label: "Payable", amount: "₹ 20000", icon: "assets/icons/payable.png"),
            ],
          ),
          const SizedBox(height: 16),

          // Sales Box
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SalesInfo(title: "Sales order", amount: "₹ 00.00"),
                Container(color: Colors.grey, height: size.height * 0.1, width: 2),
                SalesInfo(title: "Total Sales", amount: "₹ 00.00"),
                Container(color: Colors.grey, height: size.height * 0.1, width: 2),
                SalesInfo(title: "Credit sales", amount: "₹ 00.00"),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Quick Links
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Quick link", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 15,
            runSpacing: 12,
            children: const [
              QuickLink(icon: "assets/icons/q1.png", label: "Sale order"),
              QuickLink(icon: "assets/icons/Sales var.png", label: "Item"),
              QuickLink(icon: "assets/icons/q2.png", label: "Day book"),
              QuickLink(icon: "assets/icons/q3.png", label: "Customer"),
              QuickLink(icon: "assets/icons/q4.png", label: "Rent"),
              QuickLink(icon: "assets/icons/q5.png", label: "Trip"),
            ],
          ),
        ],
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final String label;
  final String amount;
  final String icon;

  const BalanceCard({super.key, required this.label, required this.amount, required this.icon});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width * 0.2,
      height: screen.height * 0.13,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(icon, width: screen.width * 0.09),
          Spacer(),
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class SalesInfo extends StatelessWidget {
  final String title;
  final String amount;

  const SalesInfo({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Text(
          amount,
          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class QuickLink extends StatelessWidget {
  final String icon;
  final String label;

  const QuickLink({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width * 0.25,
      height: screen.height * 0.14,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, width: icon == "assets/icons/q5.png" ? screen.width * 0.07 : screen.width * 0.10),
          SizedBox(height: icon == "assets/icons/q5.png" ? 0 : 6),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
