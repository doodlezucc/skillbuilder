import 'package:meta/meta.dart';

import '../io/serializable.dart';
import 'connectable.dart';
import 'board_block.dart';

abstract class LabeledData extends BoardBlock with HasOutput {
  String label;

  LabeledData({required this.label, required super.position});
  LabeledData.fromJson(Json json)
      : label = json['label'],
        super.fromJson(json);

  @override
  @mustCallSuper
  Json toJson() => {
        ...super.toJson(),
        'label': label,
      };
}
