class Action<T> {
  final T _stateFrom;
  final T _stateTo;
  final void Function(T state) _applyState;

  bool _isRun = false;

  Action(T from, T to, void Function(T state) applyState)
      : _stateFrom = from,
        _stateTo = to,
        _applyState = applyState;

  void run() {
    if (_isRun) {
      throw StateError('Action is already done');
    }

    _applyState(_stateTo);
    _isRun = true;
  }

  void unrun() {
    if (!_isRun) {
      throw StateError('Action is already undone');
    }

    _applyState(_stateFrom);
    _isRun = false;
  }
}
