import 'package:flutter_test/flutter_test.dart';
import 'package:skillbuilder/history/action.dart';
import 'package:skillbuilder/history/history.dart';

void main() {
  test('Undo empty history', () {
    expect(History().undo, throwsStateError);
  });

  test('Redo empty history', () {
    expect(History().redo, throwsStateError);
  });

  group('Register single action', () {
    final history = History();
    late int currentState;

    final action = Action(0, 1, (state) => currentState = state);

    test('Push', () {
      expect(history.isAtEndOfStack, true);

      history.push(action);

      expect(currentState, 1);
      expect(history.isAtEndOfStack, true);
    });

    test('Undo', () {
      history.undo();

      expect(currentState, 0);
      expect(history.isAtEndOfStack, false);
    });

    test('Redo', () {
      history.redo();

      expect(currentState, 1);
      expect(history.isAtEndOfStack, true);
    });
  });
}
