import 'dart:io';

import 'package:meta/meta.dart';

import '../models/board.dart';
import 'serializable.dart';

class SaveStateManager {
  File file;

  SaveState? _state;
  SaveState? get state => _state;

  SaveStateManager(this.file);

  Future<void> save() async {
    if (state == null) {
      throw StateError('No state is loaded');
    }
  }

  Future<void> load() async {}
}

class SaveState implements Serializable {
  final BoardData boardData;

  SaveState({required this.boardData});
  SaveState.fromJson(Json json) : boardData = BoardData.fromJson(json['board']);

  @override
  @mustCallSuper
  Json toJson() => {
        'board': boardData,
      };
}
