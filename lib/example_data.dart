import 'dart:ui';

import 'io/save_state.dart';
import 'models/activity.dart';
import 'models/board.dart';
import 'models/milestone.dart';
import 'models/skill.dart';

final _activityPotatoSalad = ActivityData(
  label: 'Potato Salad',
  position: const Offset(-600, 0),
);

final _activityCook = ActivityData(
  label: 'Cook',
  position: const Offset(-300, -100),
);

final _skillCookingBasics = SkillData(
  label: 'Cooking Basics',
  position: const Offset(0, -100),
);

final _skillCooking = SkillData(
  label: 'Cooking',
  position: const Offset(300, 0),
);

final _milestone = MilestoneData(
  label: 'Cook 10 Meals',
  position: const Offset(600, 0),
);

final _exampleBoard = BoardData({
  _activityPotatoSalad,
  _activityCook..ingoing.add(_activityPotatoSalad),
  _skillCookingBasics..ingoing.add(_activityCook),
  _skillCooking..ingoing.add(_skillCookingBasics),
  _milestone..ingoing.add(_skillCooking),
});

final exampleSaveState = SaveState(boardData: _exampleBoard);
