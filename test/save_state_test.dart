import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:skillbuilder/io/save_state.dart';
import 'package:skillbuilder/models/blocks/activity.dart';
import 'package:skillbuilder/models/blocks/milestone.dart';
import 'package:skillbuilder/models/blocks/skill.dart';
import 'package:skillbuilder/models/board.dart';

void main() {
  test('Restore save state', () {
    final activity = ActivityData(
      label: 'Potato Salad',
      position: const Offset(-100, 0),
    );

    final milestone = MilestoneData(
      label: 'Cook 10 Meals',
      position: const Offset(0, 0),
    );

    final skill = SkillData(
      label: 'Cooking',
      position: const Offset(100, 100),
    );

    final exampleBoard = BoardData({
      activity,
      milestone..ingoing.add(activity),
      skill..ingoing.add(milestone),
    });

    final saveState = SaveState(
      boardData: exampleBoard,
    );

    // JSON conversion applies all "toJson()" methods of nested objects
    final saveStateJson = jsonDecode(jsonEncode(saveState.toJson()));

    final restoredState = SaveState.fromJson(saveStateJson);
    final restoredStateJson = jsonDecode(jsonEncode(restoredState.toJson()));

    expect(saveStateJson, equals(restoredStateJson));
  });
}
