import 'dart:async';

import 'action.dart';
import 'history.dart';

class Historic<T> {
  final String name;
  final StreamController<Action> _streamController =
      StreamController(sync: true);

  Stream<Action> get actionStream => _streamController.stream;

  T _value;
  T get value => _value;
  set value(T value) {
    final action = Action(
      'Change $name from $_value to $value',
      _value,
      value,
      (state) => _value = state,
    );

    _streamController.add(action);

    _value = value;
  }

  Historic(this.name, T defaultValue, [History? history])
      : _value = defaultValue {
    if (history != null) {
      history.register(this);
    }
  }
}
