import 'action.dart';

class FunctionalAction extends Action<bool> {
  FunctionalAction(
    String name, {
    required void Function() forward,
    required void Function() backward,
  }) : this.callback(name, (state) => state ? forward() : backward());

  FunctionalAction.callback(String name, void Function(bool forward) callback)
      : super(name, false, true, callback);
}
