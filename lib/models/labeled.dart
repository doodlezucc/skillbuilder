import 'connectable.dart';
import 'board_object.dart';

abstract class LabeledData extends PositionedBoardObject with HasOutput {
  String label;

  LabeledData({required this.label, required super.position});
}
