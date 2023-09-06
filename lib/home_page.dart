import 'package:flutter/material.dart';
import 'board/board.dart';

import 'branding.dart';
import 'models/board.dart';
import 'models/milestone.dart';

class MyHomePage extends StatefulWidget {
  final milestoneA = MilestoneData(
    label: 'w',
    position: const Offset(0, 0),
  );

  final milestoneB = MilestoneData(
    label: "there's a curtain on the E."
        '\nit looks like an F.'
        "\nit's not an F.",
    position: const Offset(500, 300),
  );

  late final data = BoardData()
    ..objects.addAll([
      milestoneA..connections.add(milestoneB),
      milestoneB,
    ]);

  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(appName),
      ),
      body: Board(data: widget.data),
    );
  }
}
