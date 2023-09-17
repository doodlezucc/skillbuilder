import 'package:flutter/material.dart';
import 'board/board.dart';

import 'branding.dart';
import 'io/save_state.dart';

class MyHomePage extends StatefulWidget {
  final SaveState saveState;

  const MyHomePage({super.key, required this.saveState});

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
      body: Board(data: widget.saveState.boardData),
    );
  }
}
