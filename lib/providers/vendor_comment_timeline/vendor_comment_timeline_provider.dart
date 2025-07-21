import 'package:flutter/material.dart';

import '../../models/vender_event_model.dart';

class VendorCommentTimelineProvider with ChangeNotifier {
  final controller = TextEditingController();
  String name = "Vendor name", number = "+91 8152369874";
  final List<VendorEvent> _events = [VendorEvent(title: "Contact created", date: "12.02.2025", time: "12.04 PM"), VendorEvent(title: "Report approved by IMDS", date: "18.02.2025", time: "03.20 PM"), VendorEvent(title: "First trial transaction", date: "19.02.2025", time: "10.04 AM"), VendorEvent(title: "Regular supply started", date: "21.02.2025", time: "05.00 PM")];

  List<VendorEvent> get events => _events;

  void addEvent(String title, context) {
    _events.add(VendorEvent(title: title, date: DateTime.now().toString().substring(0, 10), time: TimeOfDay.now().format(context)));
    notifyListeners();
  }

  sendMessage(context) {}
}
