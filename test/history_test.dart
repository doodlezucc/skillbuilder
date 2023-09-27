import 'package:flutter_test/flutter_test.dart';
import 'package:skillbuilder/history/action.dart';
import 'package:skillbuilder/history/historic.dart';
import 'package:skillbuilder/history/history.dart';

void main() {
  test('Throw on empty history undo', () {
    expect(History().undo, throwsStateError);
  });

  test('Throw on empty history redo', () {
    expect(History().redo, throwsStateError);
  });

  test('Register single action', () {
    final history = History();
    late int currentState;

    final action = Action('0 -> 1', 0, 1, (state) => currentState = state);

    expect(history.canUndo, false);
    expect(history.canRedo, false);

    // Push
    history.push(action);
    expect(currentState, 1);
    expect(history.canUndo, true);
    expect(history.canRedo, false);

    // Undo
    history.undo();
    expect(currentState, 0);
    expect(history.canUndo, false);
    expect(history.canRedo, true);

    // Throw on second undo
    expect(history.undo, throwsStateError);

    // Redo
    history.redo();
    expect(currentState, 1);
    expect(history.canUndo, true);
    expect(history.canRedo, false);

    // Throw on second redo
    expect(history.redo, throwsStateError);
  });

  test('Purge redo stack', () {
    final history = History();
    late int currentState;

    final action0to1 = Action('0 -> 1', 0, 1, (state) => currentState = state);
    final action1to2 = Action('1 -> 2', 1, 2, (state) => currentState = state);
    final action2to3 = Action('2 -> 3', 2, 3, (state) => currentState = state);
    final action1to4 = Action('1 -> 4', 1, 4, (state) => currentState = state);

    // Push three actions
    history.push(action0to1);
    history.push(action1to2);
    history.push(action2to3);
    expect(currentState, 3);

    // Undo
    history.undo();
    expect(currentState, 2);
    expect(history.canUndo, true);
    expect(history.canRedo, true);
    history.undo();
    expect(currentState, 1);
    expect(history.canUndo, true);
    expect(history.canRedo, true);

    // Push new action
    history.push(action1to4);
    expect(currentState, 4);
    expect(history.canUndo, true);
    expect(history.canRedo, false);

    // Undo all
    history.undo();
    expect(currentState, 1);
    expect(history.canUndo, true);
    expect(history.canRedo, true);
    history.undo();
    expect(currentState, 0);
    expect(history.canUndo, false);
    expect(history.canRedo, true);

    // Redo all
    history.redo();
    expect(currentState, 1);
    expect(history.canUndo, true);
    expect(history.canRedo, true);
    history.redo();
    expect(currentState, 4);
    expect(history.canUndo, true);
    expect(history.canRedo, false);
  });

  test('Historic properties', () {
    final history = History();
    final historicInt = Historic<int>('Test Integer', 0, history);

    expect(historicInt.value, 0);

    historicInt.value = 1;
    expect(historicInt.value, 1);
    expect(history.canUndo, true);

    historicInt.value = 2;
    expect(historicInt.value, 2);

    history.undo();
    expect(historicInt.value, 1);

    history.undo();
    expect(historicInt.value, 0);

    history.redo();
    expect(historicInt.value, 1);

    history.redo();
    expect(historicInt.value, 2);
  });
}
