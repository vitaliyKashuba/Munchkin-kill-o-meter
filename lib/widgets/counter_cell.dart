import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import 'basic_square_cell.dart';
import '../shared_state.dart';

/// Cell to count gear.
/// [callback] callback from parent widget, triggered at tap.
/// [icon] gear icon.
class CounterCell extends StatefulWidget {
  final Function(Action, [int]) callback;
  final Icon icon;

  CounterCell({this.callback, this.icon});

  @override
  State<StatefulWidget> createState() => new CounterCellState();
}

class CounterCellState extends State<CounterCell> {
  int _point = 0;
  void handleTap() {
    setState(() {
      widget.callback(Action.INCREASE); //call to parent
      _point++;
    });
  }

  void handleDoubleTap() {
    setState(() {
      if (_point > 0) {
        widget.callback(Action.DECREASE);
        _point--;
      }
    });
  }

  void handleLongTap() {
    setState(() {
      widget.callback(Action.TO_ZERO, _point);
      _point = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasicSquareCell(
        onTap: handleTap,
        onDoubleTap: handleDoubleTap,
        onLongTap: handleLongTap,
        color: Colors.deepOrange[400],
        child: Center(
            child: BadgeIconButton(
              itemCount: SharedState.getGear() == 0 ? _point = 0 : _point, // if gear == 0 - wipe button was clicked, set 0
              icon: widget.icon,
              badgeColor: Colors.green,
              badgeTextColor: Colors.white,
              hideZeroCount: true,
            )));
  }
}

