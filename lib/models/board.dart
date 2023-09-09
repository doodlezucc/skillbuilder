import 'board_object.dart';
import 'connectable.dart';
import 'dependency_graph.dart';

typedef BoardContext = BoardData;

class BoardData extends DependencyGraph {
  final Set<PositionedBoardObject> _objects;
  Iterable<PositionedBoardObject> get objects => _objects;

  BoardData(Set<PositionedBoardObject> objects) : _objects = objects;

  void addObject(PositionedBoardObject object) {
    _objects.add(object);
    invalidateDependencyCache();
  }

  void removeObject(PositionedBoardObject object) {
    _objects.remove(object);

    for (final obj in _objects) {
      if (obj is HasOutput) {
        (obj as HasOutput).connections.remove(object);
      }
    }

    invalidateDependencyCache();
  }

  @override
  Iterable<Connectable> get connectables => _objects;
}
