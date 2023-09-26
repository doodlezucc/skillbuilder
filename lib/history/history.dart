import 'action.dart';

class History {
  final List<Action> _stack = [];

  int _position = 0;

  bool get isAtEndOfStack => _position == _stack.length;

  bool get canUndo => _position == 0;
  bool get canRedo => !isAtEndOfStack;

  void push(Action action) {
    if (!isAtEndOfStack) {
      _purgeRedo();
    }

    _stack.add(action);
    action.run();
    _position++;
  }

  void redo() {
    if (isAtEndOfStack) {
      throw StateError('Unable to redo at end of history');
    }

    _stack[_position].run();
    _position++;
  }

  void undo() {
    if (_position == 0) {
      throw StateError('Unable to undo at start of history');
    }

    _position--;
    _stack[_position].unrun();
  }

  void _purgeRedo() {
    _stack.removeRange(_position, _stack.length);
  }
}
