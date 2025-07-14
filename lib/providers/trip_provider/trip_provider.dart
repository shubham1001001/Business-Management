import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VehicleData {
  final String vehicleNo;
  final String driverName;
  final int fuelIntake;
  final int distanceTravelled;

  VehicleData({required this.vehicleNo, required this.driverName, required this.fuelIntake, required this.distanceTravelled});
}

class TripProvider extends ChangeNotifier {
  final List<String> months = List.generate(12, (index) {
    final month = DateTime(2025, index + 1);
    return DateFormat('MMMM yyyy').format(month); // e.g. September 2025
  });

  late String selectedMonth;

  TripProvider() {
    final now = DateTime.now();
    selectedMonth = DateFormat('MMMM yyyy').format(DateTime(2025, now.month));
    loadMonthData();
  }

  List<VehicleData> vehicleList = [];

  void loadMonthData() {
    // Replace with real API or DB logic based on selectedMonth
    vehicleList = [VehicleData(vehicleNo: 'KL 18 V 1080', driverName: 'Radhakrishna VK', fuelIntake: 120000, distanceTravelled: 35200), VehicleData(vehicleNo: 'KL 18 B 2001', driverName: 'Shaji MK', fuelIntake: 120000, distanceTravelled: 352000), VehicleData(vehicleNo: 'KL 11 A 3001', driverName: 'Anil Kumar', fuelIntake: 100000, distanceTravelled: 150000)];

    notifyListeners();
  }

  void changeMonth(String newMonth) {
    selectedMonth = newMonth;
    loadMonthData();
  }
}
