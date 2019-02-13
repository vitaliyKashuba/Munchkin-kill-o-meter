enum Action { INCREASE, DECREASE, TO_ZERO }

/// store gear value, that may be accessed from widgets of different level of parenthesis
/// replacing of global var in main.dart
/// TODO rewrite in flutter style (redux ?)
class SharedState {
  static int gear = 0;
  static Map<int, int> cellValues = Map();

  static int getGear() {
    return gear;
  }

  static void changeGear(Action action, int cellId, [int decreaseValue]) {
    switch (action) {
      case Action.INCREASE:
        cellValues.update(cellId, (dynamic val) => ++val);
        gear++;
        break;
      case Action.DECREASE:
        cellValues[cellId]--;
        gear--;
        break;
      case Action.TO_ZERO:
        cellValues[cellId]=0;
        gear = gear - decreaseValue;
        break;
    }
  }

  static void wipeGear() {
    cellValues = Map();
    gear = 0;
  }

  static int getCellValue(int id) {
    if (!cellValues.containsKey(id)) {
      cellValues[id] = 0;
    }
    return cellValues[id];
  }

}