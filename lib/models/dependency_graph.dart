import 'dart:collection';

import 'connectable.dart';

abstract class DependencyGraph<T extends Connectable> {
  Iterable<T> get connectables;

  Map<T, Set<HasOutput>>? _cachedDependencies;
  Map<T, Set<HasOutput>> get dependencies =>
      _cachedDependencies ??= computeDependencies();

  void invalidateDependencyCache() {
    _cachedDependencies = null;
  }

  Set<HasOutput> getAllDependenciesOf(T connectable) {
    final computedDeps = dependencies;

    Set<T> visited = {};
    Queue<T> unvisited = Queue()..add(connectable);

    Set<HasOutput> deps = {};

    while (unvisited.isNotEmpty) {
      final consumer = unvisited.removeFirst();
      final isNew = visited.add(consumer);

      if (!isNew) continue;

      final producers = computedDeps[consumer]!;
      deps.addAll(producers);
      unvisited.addAll(producers.cast());
    }

    return deps;
  }

  Map<T, Set<HasOutput>> computeDependencies() {
    print('compute deps');
    final connectables = this.connectables;
    final producers = connectables.whereType<HasOutput>();
    final consumers = connectables;

    Map<T, Set<HasOutput>> deps = {};

    for (final connectable in consumers) {
      deps[connectable] = {};
    }

    for (final connectable in producers) {
      for (final next in connectable.connections) {
        deps[next]!.add(connectable);
      }
    }

    return deps;
  }
}
