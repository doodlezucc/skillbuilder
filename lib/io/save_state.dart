import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../example_data.dart';
import '../models/board.dart';
import 'serializable.dart';

class SaveStateManager {
  static const usePrettyJson = true;
  static const JsonEncoder _jsonEncoder =
      usePrettyJson ? JsonEncoder.withIndent('  ') : JsonEncoder();

  static const minSaveInterval = Duration(seconds: 1);

  File file;
  Future<void>? _scheduledSave;
  bool get isSaveScheduled => _scheduledSave != null;

  SaveState? _state;
  SaveState? get state => _state;

  DateTime? _lastSaved;
  DateTime? get lastSaved => _lastSaved;

  SaveStateManager(this.file);

  Future<void> save() async {
    if (isSaveScheduled) {
      return await _scheduledSave;
    }

    if (lastSaved != null) {
      final timeSinceSave = DateTime.now().difference(lastSaved!);

      if (timeSinceSave < minSaveInterval) {
        final waitCompletion = Future.delayed(minSaveInterval - timeSinceSave);

        _scheduledSave = waitCompletion;
        await _scheduledSave;
        _scheduledSave = null;
      }
    }

    await _performSave();
  }

  Future<void> _performSave() async {
    if (state == null) {
      throw StateError('No state is loaded');
    }

    _lastSaved = DateTime.now();

    final stateJsonString = _jsonEncoder.convert(state!);
    await file.create(recursive: true);
    await file.writeAsString(stateJsonString);

    print('Saved ${file.path}');
  }

  Future<void> load() async {
    print('Loading ${file.path}');
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
