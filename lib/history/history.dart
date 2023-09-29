import 'action.dart';
import 'historic.dart';

class History {
  final List<Action> _stack = [];

  int _position = 0;

  bool get isAtEndOfStack => _position == _stack.length;

  bool get canUndo => _position > 0;
  bool get canRedo => !isAtEndOfStack;

  void push(Action action) {
    if (!isAtEndOfStack) {
      _purgeRedo();
    }

    _stack.add(action);
    action.run();
    _position++;
  }

  Action redo() {
    if (isAtEndOfStack) {
      throw StateError('Unable to redo at end of history');
    }

    final action = _stack[_position];
    action.run();
    _position++;

    return action;
  }

  Action undo() {
    if (_position == 0) {
      throw StateError('Unable to undo at start of history');
    }

    _position--;

    final action = _stack[_position];
    action.unrun();
    return action;
  }

  void _purgeRedo() {
    _stack.removeRange(_position, _stack.length);
  }

  void register(Historic historic) {
    historic.actionStream.listen((action) {
      push(action);
    });
  }
}
