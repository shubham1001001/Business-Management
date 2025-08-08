import 'package:flutter/cupertino.dart';

class AddPurchaseProvider extends ChangeNotifier {
  final mobileNumberController = TextEditingController();
  final purchaseNumberController = TextEditingController();
  final purchaseDateController = TextEditingController();
  String? rendAmountError;
  String? selectedVendorName;
  DateTime? selectedDate;
  List<String> vendors = ['vendor 1', 'vendor 2', 'vendor 3', 'vendor 4'];

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
    mobileNumberController.value = TextEditingValue(
      text: "98512458963",
      selection: TextSelection.collapsed(offset: "98512458963".length),
    );
    // mobileNumberController.selection = TextSelection.fromPosition(TextPosition(offset: mobileNumberController.text.length));
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
