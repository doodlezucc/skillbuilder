import 'package:flutter/material.dart';

import '../models/blocks/labeled.dart';
import '../models/board.dart';
import 'block.dart';

class LabeledPositioned extends StatelessWidget {
  final LabeledData data;
  final BoardContext context;
  final void Function()? onTap;
  final String? debugLabel;

  String get label {
    if (debugLabel != null) {
      return '${data.label} ($debugLabel)';
    }

    return data.label;
  }

  const LabeledPositioned(
    this.data, {
    super.key,
    required this.context,
    this.onTap,
    this.debugLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Block(
      data,
      context: this.context,
      onTap: onTap,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
