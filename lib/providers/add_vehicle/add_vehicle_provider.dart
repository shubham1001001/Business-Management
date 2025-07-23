import 'package:flutter/cupertino.dart';

class AddVehicleProvider extends ChangeNotifier {
  final vehicleNumberController = TextEditingController();
  final vehicleNameController = TextEditingController();
  final openingBalanceController = TextEditingController();
  final capacityController = TextEditingController();
  final unitController = TextEditingController();
  final typeBalanceController = TextEditingController();
  String? vehicleNumberError;
  String? vehicleNameError;
  String purchasePrice = 'INR';
  String? selectedOwner;
  List<String> owners = ['Owner name 1', 'Owner name 2', 'Owner name 3', 'Owner name 4'];

  void setOwner(String owner) {
    selectedOwner = owner;
    notifyListeners();
  }

  bool validate() {
    bool isValid = true;

    if (vehicleNumberController.text.trim().isEmpty) {
      vehicleNumberError = 'Vehicle number is required';
      isValid = false;
    } else {
      vehicleNumberError = null;
    }

    if (vehicleNameController.text.trim().isEmpty) {
      vehicleNameError = 'Vehicle name is required';
      isValid = false;
    } else {
      vehicleNameError = null;
    }

    notifyListeners();
    return isValid;
  }
}
