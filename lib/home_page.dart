import 'package:flutter/material.dart';
import 'board/board.dart';

import 'branding.dart';
import 'history/history.dart';
import 'io/save_state.dart';
import 'models/board.dart';

class MyHomePage extends StatefulWidget {
  final SaveStateManager? saveStateManager;
  final History history = History();

  MyHomePage({super.key, this.saveStateManager});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SaveState get saveState => widget.saveStateManager?.state ?? SaveState.empty;

  Future<void> save() async {
    if (widget.saveStateManager != null) {
      await widget.saveStateManager!.save();

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(appName),
        actions: [
          IconButton(
            onPressed: save,
            icon: const Icon(Icons.save_alt),
          ),
        ],
      ),
      body: Board(
        context: BoardContext(
          history: widget.history,
          saveState: saveState,
          save: save,
        ),
      ),
    );
  }
}
