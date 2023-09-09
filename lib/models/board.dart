import 'board_object.dart';
import 'connectable.dart';

class BoardData {
  final List<PositionedBoardObject> objects = [];

  void removeObject(PositionedBoardObject object) {
    objects.remove(object);

    if (object is HasInput) {
      for (final obj in objects) {
        if (obj is HasOutput) {
          obj.connections.remove(object);
        }
      }
    }
  }
}
