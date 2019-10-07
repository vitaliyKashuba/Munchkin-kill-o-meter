import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import 'basic_square_cell.dart';
import '../shared_state.dart';

/// Cell to count gear.
/// [callback] callback from parent widget, triggered at tap.
/// [icon] gear icon. ! must be unique // TODO add unique check ?
class CounterCell extends StatefulWidget {
  final Function(ActionsCustom, int, [int]) callback;
  final Icon icon;
  final int cellId ;

  CounterCell({this.callback, this.icon}) : cellId = icon.icon.codePoint;

  @override
  State<StatefulWidget> createState() => new CounterCellState();
}

class CounterCellState extends State<CounterCell> {
  int _point ;

  void handleTap() {
    setState(() {
      widget.callback(ActionsCustom.INCREASE, widget.cellId); //call to parent
      _point++;
    });
  }

  void handleDoubleTap() {
    setState(() {
      if (_point > 0) {
        widget.callback(ActionsCustom.DECREASE, widget.cellId);
        _point--;
      }
    });
  }

  void handleLongTap() {
    setState(() {
      widget.callback(ActionsCustom.TO_ZERO, widget.cellId, _point);
      _point = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    this._point = SharedState.getCellValue(widget.cellId);
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

