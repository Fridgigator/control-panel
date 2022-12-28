enum MainViewState {
  overview(0),
  hubs(1),
  fridges(2),
  settings(3);

  const MainViewState(this.value);
  final num value;

  static MainViewState getByValue(num i) {
    return MainViewState.values.firstWhere((x) => x.value == i);
  }
}
