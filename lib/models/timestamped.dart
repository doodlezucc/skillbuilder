class Timestamped<T> {
  final T defaultValue;
  final List<TimestampEntry<T>> _entries = [];

  T get value => _entries.isEmpty ? defaultValue : _entries.last.value;

  Timestamped(this.defaultValue);

  void submit(T value) {
    _entries.add(TimestampEntry(value, when: DateTime.now()));
  }

  void clear() {
    _entries.clear();
  }
}

class TimestampEntry<T> {
  final DateTime when;
  final T value;

  TimestampEntry(this.value, {required this.when});
}

extension TimestampedBool on Timestamped<bool> {
  void toggle() {
    submit(!value);
  }
}
