import 'package:flutter/material.dart';

typedef Json = Map<String, dynamic>;

extension ListJson<T> on List<T> {
  static List<T> from<T, E>(Iterable json, [T Function(E item)? map]) {
    if (map != null) {
      return json.map((item) => map(item)).toList();
    }

    return json.toList().cast<T>();
  }
}

extension SetJson<T> on Set<T> {
  static Set<T> from<T, E>(Iterable iterable, [T Function(E item)? map]) {
    if (map != null) {
      return iterable.map((item) => map(item)).toSet();
    }

    return iterable.toSet().cast<T>();
  }
}

extension OffsetJson on Offset {
  static Offset from(Json json) => Offset(
        json['x'],
        json['y'],
      );

  Json toJson() => {
        'x': dx,
        'y': dy,
      };
}

mixin Serializable {
  @mustCallSuper
  Json toJson();
}
