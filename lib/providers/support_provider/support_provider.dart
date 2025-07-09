// chat_provider.dart
import 'package:flutter/material.dart';

class SupportProvider extends ChangeNotifier {
  final List<String> _messages = [];

  List<String> get messages => _messages;

  void sendMessage(String message) {
    _messages.add(message);
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
