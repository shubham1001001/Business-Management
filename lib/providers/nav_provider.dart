import 'package:flutter/cupertino.dart';

class NavProvider with ChangeNotifier {
  int _index = 0;
  final Map<String, GlobalKey<NavigatorState>> navigatorKeys = {'Home': GlobalKey<NavigatorState>(), 'Report': GlobalKey<NavigatorState>(), 'Record': GlobalKey<NavigatorState>(), 'More': GlobalKey<NavigatorState>()};

  void onTabTapped(int index) {
    const tabs = ['Home', 'Report', 'Generate', 'Record', 'More'];
    final tab = tabs[index];
    if (_index == index) {
      navigatorKeys[tab]?.currentState?.popUntil((r) => r.isFirst);
    } else {
      _index = index;
      notifyListeners();
    }
  }

  int get currentIndex => _index;
}
