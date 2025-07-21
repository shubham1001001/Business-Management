import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

import '../../models/expence_detail_item.dart';

class ExpenseDetailProvider extends ChangeNotifier {
  final List<ExpenseItem> _items = [ExpenseItem(name: 'Item name 1', amount: 75), ExpenseItem(name: 'Item name 2', amount: 75)];

  List<ExpenseItem> get items => _items;
  double get totalAmount => _items.fold(0.0, (sum, item) => sum + item.amount);
  final AudioPlayer _player = AudioPlayer();
  Duration _position = Duration.zero;
  bool _isPlaying = false;

  Duration get position => _position;
  bool get isPlaying => _isPlaying;

  Future<void> load(String url) async {
    await _player.setUrl(url);

    _player.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });

    _player.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });
  }

  void playPause() => _isPlaying ? _player.pause() : _player.play();
  void disposePlayer() => _player.dispose();
}
