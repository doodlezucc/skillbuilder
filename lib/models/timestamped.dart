import '../io/serializable.dart';

class Timestamped<T> implements Serializable {
  final T defaultValue;
  final List<TimestampEntry<T>> _entries = [];

  T get value => _entries.isEmpty ? defaultValue : _entries.last.value;

  Timestamped(this.defaultValue);
  Timestamped.fromJson(Json json) : defaultValue = json['default'] {
    for (var jsonEntry in json.entries) {
      if (jsonEntry.key != 'default') {
        final timestamp = jsonEntry.key;
        final value = jsonEntry.value;

        final whenMillis = int.parse(timestamp);
        final when = DateTime.fromMillisecondsSinceEpoch(whenMillis);

        _entries.add(TimestampEntry(value, when: when));
      }
    }
  }

  void submit(T value) {
    _entries.add(TimestampEntry(value, when: DateTime.now()));
  }

  void clear() {
    _entries.clear();
  }

  @override
  Json toJson() => {
        'default': defaultValue,
        ...Map.fromEntries(_entries.map(
          (entry) => MapEntry(entry.timestamp, entry.value),
        ))
      };
}

class TimestampEntry<T> {
  final DateTime when;
  final T value;

  String get timestamp => '${when.millisecondsSinceEpoch}';

  TimestampEntry(this.value, {required this.when});
}

extension TimestampedBool on Timestamped<bool> {
  void toggle() {
    submit(!value);
  }
}
