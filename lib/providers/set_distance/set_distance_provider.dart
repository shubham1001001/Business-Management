import 'package:flutter/material.dart';

import '../../models/distance_item_model.dart';

class SetDistanceProvider with ChangeNotifier {
  bool isLoading = true;
  List<DistanceItemModel> distanceList = [];
  String selectedFeet = '14 feet';
  String? selectedDeliveryPoint;
  List<String> deliveryPoint = [' data 1', 'data 2', ' data 3', 'data 4'];
  DistanceProvider() {
    loadData();
  }

  void setSelectedFeet(String feet) {
    selectedFeet = feet;
    loadData(); // reload data based on feet
    notifyListeners();
  }

  void setDeliveryPoint(String value) {
    selectedDeliveryPoint = value;
    notifyListeners();
  }

  void loadData() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));
    // You can filter data based on selectedFeet
    distanceList = [
      DistanceItemModel(deliveryPoint: 'Kinfra IT park', distance: '160 KM', amount: '\$1100'),
      DistanceItemModel(deliveryPoint: 'Down town', distance: '260 KM', amount: '\$1300'),
      DistanceItemModel(deliveryPoint: 'Uphill', distance: '100 KM', amount: '\$1000'),
      DistanceItemModel(deliveryPoint: 'Malappuram', distance: '125 KM', amount: '\$1120'),
      DistanceItemModel(deliveryPoint: 'West hill', distance: '84 KM', amount: '\$600'),
      DistanceItemModel(deliveryPoint: 'Chungam', distance: '322 KM', amount: '\$2501'),
      DistanceItemModel(deliveryPoint: 'Kinfra IT park', distance: '160 KM', amount: '\$1100'),
      DistanceItemModel(deliveryPoint: 'Down town', distance: '260 KM', amount: '\$1300'),
      DistanceItemModel(deliveryPoint: 'Uphill', distance: '100 KM', amount: '\$1000'),
      DistanceItemModel(deliveryPoint: 'Malappuram', distance: '125 KM', amount: '\$1120'),
      DistanceItemModel(deliveryPoint: 'West hill', distance: '84 KM', amount: '\$600'),
      DistanceItemModel(deliveryPoint: 'Chungam', distance: '322 KM', amount: '\$2501'),
      DistanceItemModel(deliveryPoint: 'Kinfra IT park', distance: '160 KM', amount: '\$1100'),
      DistanceItemModel(deliveryPoint: 'Down town', distance: '260 KM', amount: '\$1300'),
      DistanceItemModel(deliveryPoint: 'Uphill', distance: '100 KM', amount: '\$1000'),
      DistanceItemModel(deliveryPoint: 'Malappuram', distance: '125 KM', amount: '\$1120'),
      DistanceItemModel(deliveryPoint: 'West hill', distance: '84 KM', amount: '\$600'),
      DistanceItemModel(deliveryPoint: 'Chungam', distance: '322 KM', amount: '\$2501'),
      DistanceItemModel(deliveryPoint: 'Kinfra IT park', distance: '160 KM', amount: '\$1100'),
      DistanceItemModel(deliveryPoint: 'Down town', distance: '260 KM', amount: '\$1300'),
      DistanceItemModel(deliveryPoint: 'Uphill', distance: '100 KM', amount: '\$1000'),
      DistanceItemModel(deliveryPoint: 'Malappuram', distance: '125 KM', amount: '\$1120'),
      DistanceItemModel(deliveryPoint: 'West hill', distance: '84 KM', amount: '\$600'),
      DistanceItemModel(deliveryPoint: 'Chungam', distance: '322 KM', amount: '\$2501'),
    ];
    isLoading = false;
    notifyListeners();
  }
}
