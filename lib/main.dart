import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:badges/badges.dart';

import './presentation/custom_icons_icons.dart';

void main() {
//  debugPaintSizeEnabled=true;
  runApp(MyApp());
}

enum Action { INCREASE, DECREASE, TO_ZERO }
final double MAIN_ICON_SIZE = 36;

int gear = 0; // TODO refactor without global var ?

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Munchkin kill-o-meter',
      theme: new ThemeData(
        primaryColor: Colors.deepOrange[600],
        accentColor: Colors.deepOrangeAccent,
        highlightColor: Colors.deepOrangeAccent[200],
        fontFamily: 'MunchkinFonts'
      ),
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  @override
  MainWidgetState createState() => new MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  int level = 1;

  /// Triggered in child (CounterCell) widgets. used to change both cell and total count values
  callback(Action action, [int decreaseValue]) {
    setState(() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Munchkin kill-o-meter'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    int total = gear+level;

    return Ink( // TODO refactor ? Extract widgets ?
      color: Colors.deepOrange[100],
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/munch.png", height: 180)
            ],
          ),
          Align(
              alignment: FractionalOffset.topCenter,
              child: Opacity(
                opacity: 0.85,
                child: Card(
                    child: Padding(
                    padding: const EdgeInsets.only(left: 35, top: 10, right: 35, bottom: 10),
                        child: Text("$total", style: TextStyle(
                            fontSize: 48
                          )
                        )
                    )
                ),
              )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () { setState(() { if (level>1) level--; }); },
                  ),
                  BasicSquareCell(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text("level", style: TextStyle(
                            fontSize: 24,
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text("$level", style: TextStyle(
                              fontSize: MAIN_ICON_SIZE,
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () { setState(() { level++; }); },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CounterCell(
                      callback: callback,
                      icon: Icon(CustomIcons.ring1, size: MAIN_ICON_SIZE)),
                  CounterCell(
                      callback: callback,
                      icon: Icon(CustomIcons.helmet, size: MAIN_ICON_SIZE)),
                  CounterCell(
                      callback: callback,
                      icon: Icon(CustomIcons.ring2, size: MAIN_ICON_SIZE)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CounterCell(
                      callback: callback,
                      icon: Icon(CustomIcons.sword, size: MAIN_ICON_SIZE)),
                  CounterCell(
                      callback: callback,
                      icon: Icon(CustomIcons.armor, size: MAIN_ICON_SIZE)),
                  CounterCell(
                      callback: callback,
                      icon: Icon(CustomIcons.shield, size: MAIN_ICON_SIZE)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
//              BasicSquareCell(),
                  BasicSquareCell(),
                  CounterCell(
                      callback: callback,
                      icon: Icon(CustomIcons.boot, size: MAIN_ICON_SIZE)),
                  BasicSquareCell(
                    child: GestureDetector(
                        onLongPress: () => setState(() {
                              gear = 0;
                            }),
                        child: FloatingActionButton(
                          onPressed: () {},
                          child: Icon(CustomIcons.skull),
                        )),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

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
          itemCount: gear == 0 ? _point = 0 : _point, // if gear == 0 - wipe button was clicked, set 0
          icon: widget.icon,
          badgeColor: Colors.green,
          badgeTextColor: Colors.white,
          hideZeroCount: true,
        )));
  }
}

/// Used to wrap content, that should be aligned as Counter cells
class BasicSquareCell extends StatefulWidget {
  final Widget child;
  final Function() onTap, onDoubleTap, onLongTap;
  final Color color;

  BasicSquareCell(
      {this.child, this.onTap, this.onDoubleTap, this.onLongTap, this.color}) {}

  @override
  State<StatefulWidget> createState() => new BasicSquareCellState();
}

class BasicSquareCellState extends State<BasicSquareCell> {
  void handleLongTap() {
    setState(() {
      print(widget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        highlightColor: Colors.deepOrangeAccent[200],
        onTap: widget.onTap,
        onDoubleTap: widget.onDoubleTap,
        onLongPress: widget.onLongTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Ink(
              width: 80,
              height: 80,
              color: widget.color,
              child: widget.child == null ? Container() : widget.child),
        ));
  }
}
