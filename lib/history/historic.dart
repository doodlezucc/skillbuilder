import 'dart:async';

import 'action.dart';
import 'history.dart';

class Historic<T> {
  final StreamController<Action> _streamController = StreamController();

  Stream<Action> get actionStream => _streamController.stream;

  T _value;
  T get value => _value;
  set value(T value) {
    final action = Action(_value, value, (state) => _value = state);
    _streamController.add(action);

    _value = value;
  }

  Historic(T defaultValue, [History? history]) : _value = defaultValue {
    if (history != null) {
      history.register(this);
    }
  }
}
