import 'action.dart';

class FunctionalAction extends Action<bool> {
  FunctionalAction({
    required void Function() forward,
    required void Function() backward,
  }) : this.callback((state) => state ? forward : backward);

  FunctionalAction.callback(void Function(bool forward) callback)
      : super(false, true, callback);
}
