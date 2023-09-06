import 'board_object.dart';

mixin HasInput on BoardObject {}

mixin HasOutput on BoardObject {
  List<HasInput> connections = [];
}
