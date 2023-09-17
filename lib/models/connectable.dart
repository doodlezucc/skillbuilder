mixin Connectable {}

mixin HasInput on Connectable {
  Set<HasOutput> ingoing = {};
}

mixin HasOutput on Connectable {}
