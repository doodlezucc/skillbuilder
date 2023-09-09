import 'board_object.dart';

mixin HasInput on PositionedBoardObject {}

mixin HasOutput on PositionedBoardObject {
  List<HasInput> connections = [];
}
