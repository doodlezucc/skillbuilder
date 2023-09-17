import 'dart:collection';

import 'connectable.dart';

abstract class DependencyGraph<T extends Connectable> {
  Iterable<T> get connectables;

  Set<HasOutput> getAllDependenciesOf(HasInput connectable) {
    Set<Connectable> visited = {};
    Queue<Connectable> unvisited = Queue()..add(connectable);

    Set<HasOutput> deps = {};

    while (unvisited.isNotEmpty) {
      final consumer = unvisited.removeFirst();
      final isNew = visited.add(consumer);

      if (!isNew) continue;

      if (consumer is HasInput) {
        final producers = consumer.ingoing;
        deps.addAll(producers);
        unvisited.addAll(producers);
      }
    }

    return deps;
  }

  List<(HasOutput, HasInput)> getConnectionPairs() {
    final pairs = <(HasOutput, HasInput)>[];

    for (final consumer in connectables.whereType<HasInput>()) {
      pairs.addAll(consumer.ingoing.map(
        (producer) => (producer, consumer),
      ));
    }

    return pairs;
  }
}
