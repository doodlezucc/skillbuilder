import 'action.dart';
import 'history.dart';

class Historic<T> {
  final History _history;

  T _value;
  T get value => _value;
  set value(T value) {
    _history.push(Action(_value, value, (state) => _value = state));

    _value = value;
  }

  Historic(History history, T defaultValue)
      : _history = history,
        _value = defaultValue;
}
