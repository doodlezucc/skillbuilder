mixin Connectable {}

mixin HasOutput on Connectable {
  Set<Connectable> connections = {};
}
