import '../io/save_state.dart';
import '../io/serializable.dart';
import 'blocks/board_block.dart';
import 'connectable.dart';
import 'dependency_graph.dart';

class BoardContext {
  final SaveState _saveState;
  final Future<void> Function() save;

  BoardData get board => _saveState.boardData;

  BoardContext({
    required SaveState saveState,
    required this.save,
  }) : _saveState = saveState;
}

class BoardData extends DependencyGraph with Serializable {
  final Set<BoardBlock> _blocks;
  Iterable<BoardBlock> get blocks => _blocks;

  BoardData(Set<BoardBlock> blocks) : _blocks = blocks;
  BoardData.fromJson(Json json) : _blocks = {} {
    final Iterable blockIterable = json['blocks'];
    final Map<int, BoardBlock> idOfBlocks =
        blockIterable.toParsedIdMap(BoardBlock.parse);

    _blocks.addAll(idOfBlocks.values);

    final Iterable dynamicPairs = json['connections'];
    final idPairs = dynamicPairs.cast<List>().mapToTuples<int, int>();
    final pairs = idPairs.mapByLookup(idOfBlocks);

    applyConnectionPairs(pairs);
  }

  void addBlock(BoardBlock block) {
    _blocks.add(block);
  }

  void removeBlock(BoardBlock block) {
    _blocks.remove(block);

    for (final other in _blocks) {
      if (other is HasInput) {
        (other as HasInput).ingoing.remove(block);
      }
    }
  }

  @override
  Iterable<Connectable> get connectables => _blocks;

  @override
  Json toJson() {
    final ids = _blocks.makeIdMap();

    return {
      'blocks': _blocks.toJsonWithIds(ids).toList(),
      'connections': getConnectionPairs()
          .mapByLookup(ids)
          .map((tuple) => [tuple.$1, tuple.$2])
          .toList(),
    };
  }
}
