import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../example_data.dart';
import '../models/board.dart';
import 'serializable.dart';

class SaveStateManager {
  static const usePrettyJson = false;
  static const JsonEncoder _jsonEncoder =
      usePrettyJson ? JsonEncoder.withIndent('  ') : JsonEncoder();

  static const minSaveInterval = Duration(seconds: 1);

  File file;
  Future<void>? _saveCompletion;
  bool get isSaving => _saveCompletion != null;

  SaveState? _state;
  SaveState? get state => _state;

  DateTime? _lastSaved;
  DateTime? get lastSaved => _lastSaved;

  SaveStateManager(this.file);

  Future<void> save() async {
    if (!isSaving) {
      if (lastSaved == null) {
        _saveCompletion = _performSave();
      } else {
        final timeSinceSave = DateTime.now().difference(lastSaved!);

        if (timeSinceSave < minSaveInterval) {
          final waitCompletion =
              Future.delayed(minSaveInterval - timeSinceSave);

          _saveCompletion = waitCompletion.then((_) => _performSave());
        } else {
          _saveCompletion = _performSave();
        }
      }
    }

    await _saveCompletion;
    _saveCompletion = null;
  }

  Future<void> _performSave() async {
    if (state == null) {
      throw StateError('No state is loaded');
    }

    final stateJsonString = _jsonEncoder.convert(state!);
    await file.create(recursive: true);
    await file.writeAsString(stateJsonString);

    _lastSaved = DateTime.now();

    print('Saved ${file.path}');
  }

  Future<void> load() async {
    final stateJsonString = await file.readAsString();
    final stateJson = jsonDecode(stateJsonString);

    _state = SaveState.fromJson(stateJson);

    print('Loaded ${file.path}');
  }

  Future<void> loadOrUseDefault() async {
    try {
      await load();
    } on FileSystemException catch (_) {
      _state = exampleSaveState;
      print('Using example save state');
    }
  }
}

class SaveState implements Serializable {
  static final SaveState empty = SaveState(
    boardData: BoardData({}),
  );

  final BoardData boardData;

  SaveState({required this.boardData});
  SaveState.fromJson(Json json) : boardData = BoardData.fromJson(json['board']);

  @override
  Json toJson() => {
        'board': boardData,
      };
}
