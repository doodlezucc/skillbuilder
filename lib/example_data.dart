import 'dart:ui';

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

final exampleData = BoardData()
  ..objects.addAll([
    _activityPotatoSalad..connections.add(_activityCook),
    _activityCook..connections.add(_skillCookingBasics),
    _skillCookingBasics..connections.add(_skillCooking),
    _skillCooking..connections.add(_milestone),
    _milestone,
  ]);
