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

extension IterableJson<T extends Serializable> on Iterable<T> {
  Iterable<Json> toJsonWithIds(Map<T, int> ids) {
    return map((item) => {
          'id': ids[item],
          ...item.toJson(),
        });
  }

  Map<T, int> makeIdMap() {
    int currentId = 0;
    Map<T, int> idMap = {};

    for (final item in this) {
      idMap[item] = currentId++;
    }

    return idMap;
  }
}

extension TupleIterable<A, B> on Iterable<(A, B)> {
  Iterable<(O, O)> mapByLookup<I, O>(Map<I, O> lookup) {
    O doLookup(I input) {
      return lookup[input] as O;
    }

    return map((tuple) {
      final (a, b) = tuple;
      return (doLookup(a as I), doLookup(b as I));
    });
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
