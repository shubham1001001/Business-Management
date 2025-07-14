import 'package:flutter/cupertino.dart';

import '../models/vehicle_overview_model.dart';

class VehicleOverviewProvider with ChangeNotifier {
  final List<VehicleOverviewModel> _allVehicles = [
    VehicleOverviewModel(vehicleNo: 'KL 11 B 1048', name: 'Space for large name to view', capacity: '12 ton', description: 'Own vehicle, lorem ipsu', category: 'Lorem', distance: '60200 KM'),
    VehicleOverviewModel(vehicleNo: 'KL 10 AA 1328', name: 'a small name', capacity: '12 ton', description: 'Own vehicle, lorem ipsu', category: 'Lorem', distance: '60200 KM'),
    VehicleOverviewModel(vehicleNo: 'KL 19 G 2048', name: 'Space for large name to view', capacity: '12 ton', description: 'Own vehicle, lorem ipsu', category: 'Lorem', distance: '60200 KM'),
    VehicleOverviewModel(vehicleNo: 'KL 11 B 1048', name: 'Space for large name to view', capacity: '12 ton', description: 'Own vehicle, lorem ipsu', category: 'Lorem', distance: '60200 KM'),
    VehicleOverviewModel(vehicleNo: 'KL 11 B 1048', name: 'Space for large name to view', capacity: '12 ton', description: 'Own vehicle, lorem ipsu', category: 'Lorem', distance: '60200 KM'),
    // Add more...
  ];

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  List<VehicleOverviewModel> get filteredVehicles {
    if (_searchQuery.isEmpty) return _allVehicles;
    return _allVehicles.where((v) => v.vehicleNo.toLowerCase().contains(_searchQuery.toLowerCase()) || v.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }
}
