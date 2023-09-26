import 'package:flutter_test/flutter_test.dart';
import 'package:skillbuilder/history/action.dart';
import 'package:skillbuilder/history/history.dart';

void main() {
  test('Throw on empty history undo', () {
    expect(History().undo, throwsStateError);
  });

  test('Throw on empty history redo', () {
    expect(History().redo, throwsStateError);
  });

  group('Register single action', () {
    final history = History();
    late int currentState;

    final action = Action(0, 1, (state) => currentState = state);

    test('Push', () {
      expect(history.canUndo, false);
      expect(history.canRedo, false);

      history.push(action);

      expect(currentState, 1);
      expect(history.canUndo, true);
      expect(history.canRedo, false);
    });

    test('Undo', () {
      history.undo();

      expect(currentState, 0);
      expect(history.canUndo, false);
      expect(history.canRedo, true);
    });

    test('Throw on second undo', () {
      expect(history.undo, throwsStateError);
    });

    test('Redo', () {
      history.redo();

      expect(currentState, 1);
      expect(history.canUndo, true);
      expect(history.canRedo, false);
    });

    test('Throw on second redo', () {
      expect(history.redo, throwsStateError);
    });
  });
}
