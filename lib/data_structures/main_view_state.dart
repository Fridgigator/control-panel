enum MainViewState {
  main(0),
  hubs(1),
  sensors(2),
  fridges(3),
  settings(4);

  const MainViewState(this.value);
  final num value;

  static MainViewState getByValue(num i) {
    return MainViewState.values.firstWhere((x) => x.value == i);
  }
}
