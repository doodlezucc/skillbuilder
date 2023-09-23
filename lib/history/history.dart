import 'action.dart';

class History {
  final List<Action> _stack = [];

  int _position = 0;

  bool get isAtEndOfStack => _position == _stack.length;
  bool get canRedo => !isAtEndOfStack;

  void push(Action action) {
    if (!isAtEndOfStack) {
      _purgeRedo();
    }

    _stack.add(action);
    action.run();
    _position++;
  }

  void undo() {
    final poppedAction = _stack.removeLast();
    poppedAction.unrun();
    _position--;
  }

  void _purgeRedo() {
    _stack.removeRange(_position, _stack.length);
  }
}
