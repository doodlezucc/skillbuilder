import 'dart:convert';
import 'dart:io';

import '../models/board.dart';
import 'serializable.dart';

class SaveStateManager {
  static const JsonEncoder jsonEncoder = JsonEncoder.withIndent('  ');

  File file;

  SaveState? _state;
  SaveState? get state => _state;

  SaveStateManager(this.file);

  Future<void> save() async {
    if (state == null) {
      throw StateError('No state is loaded');
    }

    final stateJsonString = jsonEncoder.convert(state);
    await file.create(recursive: true);
    await file.writeAsString(stateJsonString);

    print('Saved!');
  }

  Future<void> load() async {
    final stateJsonString = await file.readAsString();
    final stateJson = jsonDecode(stateJsonString);

    _state = SaveState.fromJson(stateJson);

    print('Loaded!');
  }
}

class SaveState implements Serializable {
  final BoardData boardData;

  SaveState({required this.boardData});
  SaveState.fromJson(Json json) : boardData = BoardData.fromJson(json['board']);

  @override
  Json toJson() => {
        'board': boardData,
      };
}
