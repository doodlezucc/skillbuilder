import 'board_object.dart';
import 'connectable.dart';

class BoardData {
  final List<BoardObject> objects = [];

  void removeObject(BoardObject object) {
    objects.remove(object);

    for (final obj in objects) {
      if (obj is HasOutput) {
        obj.connections.remove(object);
      }
    }
  }
}
