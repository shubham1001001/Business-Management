import 'package:flutter/material.dart';

class CustomerBalanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text('Customer Balance'), backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomerBalanceCard(customerName: 'Balam KP', totalAmount: 1000, orderNumber: '0001', date: '12.02.2025', customerBalance: -200, isSold: true),
              SizedBox(height: 16),
              // Add more cards here if needed
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerBalanceCard extends StatelessWidget {
  final String customerName;
  final double totalAmount;
  final String orderNumber;
  final String date;
  final double customerBalance;
  final bool isSold;

  const CustomerBalanceCard({Key? key, required this.customerName, required this.totalAmount, required this.orderNumber, required this.date, required this.customerBalance, required this.isSold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 20 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer name',
                        style: TextStyle(fontSize: isTablet ? 14 : 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 4),
                      Text(
                        customerName,
                        style: TextStyle(fontSize: isTablet ? 18 : 16, fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      orderNumber,
                      style: TextStyle(fontSize: isTablet ? 14 : 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(fontSize: isTablet ? 14 : 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16),

            // Total Amount Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total amount',
                  style: TextStyle(fontSize: isTablet ? 14 : 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
                Text(
                  '₹ ${totalAmount.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: isTablet ? 18 : 16, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Divider
            Container(height: 1, color: Colors.grey[200]),

            SizedBox(height: 16),

            // Customer Balance Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer balance',
                      style: TextStyle(fontSize: isTablet ? 14 : 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '₹ ${customerBalance.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: isTablet ? 20 : 18, fontWeight: FontWeight.w700, color: customerBalance < 0 ? Colors.red[600] : Colors.green[600]),
                    ),
                  ],
                ),
                if (isSold)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 12, vertical: isTablet ? 8 : 6),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green[200]!, width: 1),
                    ),
                    child: Text(
                      'Sold',
                      style: TextStyle(fontSize: isTablet ? 14 : 12, fontWeight: FontWeight.w600, color: Colors.green[700]),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Alternative card design with gradient
class CustomerBalanceCardGradient extends StatelessWidget {
  final String customerName;
  final double totalAmount;
  final String orderNumber;
  final String date;
  final double customerBalance;
  final bool isSold;

  const CustomerBalanceCardGradient({Key? key, required this.customerName, required this.totalAmount, required this.orderNumber, required this.date, required this.customerBalance, required this.isSold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white, Colors.blue[50]!]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.1), spreadRadius: 2, blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row with icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(8)),
                      child: Icon(Icons.person, color: Colors.blue[700], size: isTablet ? 24 : 20),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Customer name',
                          style: TextStyle(fontSize: isTablet ? 14 : 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 2),
                        Text(
                          customerName,
                          style: TextStyle(fontSize: isTablet ? 18 : 16, fontWeight: FontWeight.w700, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        orderNumber,
                        style: TextStyle(fontSize: isTablet ? 12 : 10, fontWeight: FontWeight.w600, color: Colors.grey[700]),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(fontSize: isTablet ? 14 : 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            // Amount and Balance in cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total amount',
                          style: TextStyle(fontSize: isTablet ? 12 : 10, color: Colors.grey[600], fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹ ${totalAmount.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: isTablet ? 18 : 16, fontWeight: FontWeight.w700, color: Colors.blue[700]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: customerBalance < 0 ? Colors.red[50] : Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: customerBalance < 0 ? Colors.red[200]! : Colors.green[200]!, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Balance',
                          style: TextStyle(fontSize: isTablet ? 12 : 10, color: Colors.grey[600], fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹ ${customerBalance.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: isTablet ? 18 : 16, fontWeight: FontWeight.w700, color: customerBalance < 0 ? Colors.red[700] : Colors.green[700]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            if (isSold) ...[
              SizedBox(height: 16),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: isTablet ? 20 : 16, vertical: isTablet ? 10 : 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.green[400]!, Colors.green[600]!]),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.3), blurRadius: 8, offset: Offset(0, 4))],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: isTablet ? 18 : 16),
                      SizedBox(width: 8),
                      Text(
                        'Sold',
                        style: TextStyle(fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
