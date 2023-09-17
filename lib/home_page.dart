import 'package:flutter/material.dart';
import 'board/board.dart';

import 'branding.dart';
import 'io/save_state.dart';

class MyHomePage extends StatefulWidget {
  final SaveStateManager? saveStateManager;

  const MyHomePage({super.key, this.saveStateManager});

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
      body: Board(data: saveState.boardData),
    );
  }
}
