class Action<T> {
  final T _stateFrom;
  final T _stateTo;
  final void Function(T state) _applyState;
  final String name;

  bool _isRun = false;

  Action(this.name, T from, T to, void Function(T state) applyState)
      : _stateFrom = from,
        _stateTo = to,
        _applyState = applyState;

  void run() {
    if (_isRun) {
      throw StateError('Action is already done');
    }

    print('Doing "$name"');
    _applyState(_stateTo);
    _isRun = true;
  }

  void unrun() {
    if (!_isRun) {
      throw StateError('Action is already undone');
    }

    print('Undoing "$name"');
    _applyState(_stateFrom);
    _isRun = false;
  }
}
