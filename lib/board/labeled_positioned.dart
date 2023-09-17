import 'package:flutter/material.dart';

import '../models/labeled.dart';
import 'block.dart';

class LabeledPositioned extends StatelessWidget {
  final LabeledData data;
  final void Function() onDelete;
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
    required this.onDelete,
    this.onTap,
    this.debugLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Block(
      data,
      onDelete: onDelete,
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
