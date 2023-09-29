import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'toasts/toast.dart';
import 'toasts/toast_container.dart';
import 'toasts/toast_controller.dart';
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
  final toastController = ToastController();

  SaveState get saveState => widget.saveStateManager?.state ?? SaveState.empty;

  Future<void> save() async {
    if (widget.saveStateManager != null) {
      await widget.saveStateManager!.save();

      setState(() {});
    }
  }

  void _tryUndo() {
    if (widget.history.canUndo) {
      setState(() {
        final action = widget.history.undo();
        toastController.push(Toast('Undo: ${action.name}', icon: Icons.undo));
      });
    }
  }

  void _tryRedo() {
    if (widget.history.canRedo) {
      setState(() {
        final action = widget.history.redo();
        toastController.push(Toast(action.name, icon: Icons.redo));
      });
    }
  }

  Map<ShortcutActivator, void Function()> getBindings() => {
        const SingleActivator(LogicalKeyboardKey.keyZ, control: true): _tryUndo,
        const SingleActivator(LogicalKeyboardKey.keyY, control: true): _tryRedo,
        const SingleActivator(LogicalKeyboardKey.keyZ,
            shift: true, control: true): _tryRedo,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
            onPressed: save,
            icon: const Icon(Icons.save_alt),
          ),
        ],
      ),
      body: CallbackShortcuts(
        bindings: getBindings(),
        child: Focus(
          autofocus: true,
          child: Stack(
            children: [
              Board(
                context: BoardContext(
                  history: widget.history,
                  saveState: saveState,
                  save: save,
                ),
              ),
              ToastContainer(controller: toastController),
            ],
          ),
        ),
      ),
    );
  }
}
