import 'dart:async';

import 'toast.dart';

class ToastController {
  final StreamController<Toast> _streamController =
      StreamController.broadcast();

  Stream<Toast> get stream => _streamController.stream;

  void push(Toast toast) {
    _streamController.add(toast);
  }
}
