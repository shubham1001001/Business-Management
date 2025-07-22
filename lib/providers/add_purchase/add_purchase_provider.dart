import 'package:flutter/cupertino.dart';

class AddPurchaseProvider extends ChangeNotifier {
  final mobileNumberController = TextEditingController();
  final purchaseNumberController = TextEditingController();
  final purchaseDateController = TextEditingController();
  String? rendAmountError;
  String? selectedVendorName;
  DateTime? selectedDate;
  List<String> owners = [' data 1', 'data 2', ' data 3', 'data 4'];

  void setVendorName(String value) {
    selectedVendorName = value;
    notifyListeners();
    mobileNumber();
  }

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void mobileNumber() {
    mobileNumberController.text = "91 8512458963 ";
    notifyListeners();
  }

  bool validate() {
    bool isValid = true;

    if (purchaseNumberController.text.trim().isEmpty && purchaseNumberController.text.trim().isEmpty && purchaseDateController.text.trim().isEmpty) {
      rendAmountError = 'All Fields is required';
      isValid = false;
    } else {
      rendAmountError = null;
    }
    notifyListeners();
    return isValid;
  }
}
