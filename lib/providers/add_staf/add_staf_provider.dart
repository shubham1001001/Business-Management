import 'dart:io';

import 'package:flutter/material.dart';

class AddStafProvider extends ChangeNotifier {
  File? profileImage;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  String employeeType = 'Full Time';
  String phone = '';
  void setProfileImage(File image) {
    profileImage = image;
    notifyListeners();
  }

  void setEmployeeType(String? type) {
    if (type != null) {
      employeeType = type;
      notifyListeners();
    }
  }

  void updatePhone(String value) {
    phone = value;
    notifyListeners();
  }

  bool get isPhoneValid {
    // Accepts 10-digit mobile numbers only (India-style)
    final regex = RegExp(r'^[6-9]\d{9}$');
    return regex.hasMatch(phone);
  }

  bool validateForm() {
    return nameController.text.isNotEmpty && phoneController.text.isNotEmpty && addressController.text.isNotEmpty;
  }

  void submitForm() {
    if (validateForm()) {
      debugPrint('Name: ${nameController.text}');
      debugPrint('Phone: ${phoneController.text}');
      debugPrint('Address: ${addressController.text}');
      debugPrint('Type: $employeeType');
      debugPrint('Image: ${profileImage?.path}');
    } else {
      debugPrint('Validation failed');
    }
  }
}
