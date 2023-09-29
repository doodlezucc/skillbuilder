import 'package:flutter/material.dart';

import '../models/blocks/labeled.dart';
import 'block.dart';

class LabeledPositioned extends Block<LabeledData> {
  final String? debugLabel;

  String get label {
    if (debugLabel != null) {
      return '${data.label} ($debugLabel)';
    }

    return data.label;
  }

  const LabeledPositioned(
    super.data, {
    super.key,
    required super.context,
    super.onTap,
    this.debugLabel,
  });

  @override
  Widget buildChild(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
