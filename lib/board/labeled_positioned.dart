import 'package:flutter/material.dart';

import '../models/labeled.dart';
import 'positioned.dart';

class LabeledPositioned extends StatelessWidget {
  final LabeledData data;
  final void Function() onDelete;

  const LabeledPositioned(this.data, {super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return PositionedObject(
      data,
      onDelete: onDelete,
      child: Text(
        data.label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
