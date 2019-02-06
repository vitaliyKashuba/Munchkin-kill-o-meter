enum Action { INCREASE, DECREASE, TO_ZERO }

/// store gear value, that may be accessed from widgets of different level of parenthesis
/// replacing of global var in main.dart
/// TODO rewrite in flutter style (redux ?)
class SharedState {
  static int gear = 0;

  static int getGear() {
    return gear;
  }

  static void changeGear(Action action, [int decreaseValue]) {
    switch (action) {
      case Action.INCREASE:
        gear++;
        break;
      case Action.DECREASE:
        gear--;
        break;
      case Action.TO_ZERO:
        gear = gear - decreaseValue;
        break;
    }
  }

  static void wipeGear() {
    gear = 0;
  }

}