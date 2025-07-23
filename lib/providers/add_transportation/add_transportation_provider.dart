import 'package:flutter/cupertino.dart';

class AddTransportationProvider extends ChangeNotifier {
  final rentAmountController = TextEditingController();
  String? rendAmountError;
  String? selectedCollectionPoint;
  String? selectedDeliveryPoint;
  String? selectedVehicleNumber;
  String? selectedDriver;
  List<String> owners = [' data 1', 'data 2', ' data 3', 'data 4'];

  void setCollectionPoint(String value) {
    selectedCollectionPoint = value;
    notifyListeners();
  }

  void setDeliveryPoint(String value) {
    selectedDeliveryPoint = value;
    notifyListeners();
  }

  void setVehicleNumber(String value) {
    selectedVehicleNumber = value;
    notifyListeners();
  }

  void setDriver(String value) {
    selectedDriver = value;
    notifyListeners();
  }

  bool validate() {
    bool isValid = true;

    if (rentAmountController.text.trim().isEmpty) {
      rendAmountError = 'Vehicle number is required';
      isValid = false;
    } else {
      rendAmountError = null;
    }
    notifyListeners();
    return isValid;
  }
}
