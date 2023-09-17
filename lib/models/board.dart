import '../io/serializable.dart';
import 'board_object.dart';
import 'connectable.dart';
import 'dependency_graph.dart';

typedef BoardContext = BoardData;

class BoardData extends DependencyGraph with Serializable {
  final Set<PositionedBoardObject> _objects;
  Iterable<PositionedBoardObject> get objects => _objects;

  BoardData(Set<PositionedBoardObject> objects) : _objects = objects;
  BoardData.fromJson(Json json)
      : _objects = SetJson.from(json['blocks'], PositionedBoardObject.parse);

  void addObject(PositionedBoardObject object) {
    _objects.add(object);
  }

  void removeObject(PositionedBoardObject object) {
    _objects.remove(object);

    for (final obj in _objects) {
      if (obj is HasInput) {
        (obj as HasInput).ingoing.remove(object);
      }
    }
  }

  @override
  Iterable<Connectable> get connectables => _objects;

  @override
  Json toJson() => {
        'blocks': _objects.toList(),
      };
}
