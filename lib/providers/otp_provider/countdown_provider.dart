import 'dart:async';

import 'package:flutter/material.dart';

class CountdownProvider with ChangeNotifier {
  int _remainingTime = 30;
  Timer? _timer;

  int get remainingTime => _remainingTime;

  bool get isRunning => _timer?.isActive ?? false;

  void startTimer() {
    _remainingTime = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
    notifyListeners();
  }

  void stopTimer() {
    _timer?.cancel();
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    _remainingTime = 30;
    notifyListeners();
  }
}
