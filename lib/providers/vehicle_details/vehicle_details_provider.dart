import 'package:flutter/material.dart';

import '../../models/trip_model.dart';

class VehicleDetailsProvider with ChangeNotifier {
  bool isLoading = true;
  bool isTripSelected = true;
  String selectedFilter = "Today";
  List<TripModel> tripList = [];
  List<TripModel> vehicleList = [];

  void toggleTab(bool trip) {
    isTripSelected = trip;
    loadTripData();
  }

  void setFilter(String filter) {
    selectedFilter = filter;
    loadTripData();
  }

  Future<void> loadTripData() async {
    isLoading = true;
    tripList = [];
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    if (!isTripSelected) {
      tripList = [TripModel(deliveryPoint: "Vehicle Log A", amount: 10000), TripModel(deliveryPoint: "Vehicle Log B", amount: 5000), TripModel(deliveryPoint: "Vehicle Log A", amount: 10000), TripModel(deliveryPoint: "Vehicle Log B", amount: 5000)];
    } else if (selectedFilter == "Today") {
      tripList = [TripModel(deliveryPoint: "Delivery point 1", amount: 5222), TripModel(deliveryPoint: "Delivery point 2", amount: 5442)];
    } else if (selectedFilter == "Week") {
      tripList = [TripModel(deliveryPoint: "Delivery point A", amount: 12000), TripModel(deliveryPoint: "Delivery point B", amount: 8800), TripModel(deliveryPoint: "Delivery point C", amount: 3300)];
    } else if (selectedFilter == "Month") {
      tripList = [TripModel(deliveryPoint: "Delivery X", amount: 25000), TripModel(deliveryPoint: "Delivery Y", amount: 10000), TripModel(deliveryPoint: "Delivery Z", amount: 18775)];
    }

    isLoading = false;
    notifyListeners();
  }
}
