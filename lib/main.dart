import 'dart:async';
import 'dart:math';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:badges/badges.dart';

import 'shared_state.dart';
import 'layout_util.dart';
import './presentation/custom_icons_icons.dart';
import './widgets/basic_square_cell.dart';
import './widgets/counter_cell.dart';

void main() {
//  debugPaintSizeEnabled=true;
  runApp(MyApp());
}

final double MAIN_ICON_SIZE = 36;

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
  int total;

  /// Triggered in child (CounterCell) widgets.
  /// should be called to run setState, that why not interacting with shared state from child widgets
  callback(Action action, [int decreaseValue]) {
    setState(() {
      SharedState.changeGear(action, decreaseValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    total = SharedState.getGear()+level;

    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
            appBar: orientation == Orientation.portrait ? buildAppBar() : null,
            body: Ink(
                color: Colors.deepOrange[100],
                padding: EdgeInsets.all(LayoutUtil.getMainPadding()),
                child: orientation == Orientation.portrait
                    ? buildVerticalLayout()
                    : buildHorizontalLayout()
            )
        );
      },
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text('Munchkin kill-o-meter'),
    );
  }

  Widget buildVerticalLayout() {
    return Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: buildTotalLeveCardWithImage()
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildMainGrid()
          ],
        )
      ],
    );
  }

  buildHorizontalLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTotalLeveCardWithImage(),
        buildMainGrid()
      ],
    );
  }

  /// build level card with background image
  Widget buildTotalLeveCardWithImage() {
    double containerSize = LayoutUtil.calculateTabSize(context);

    return Container(
        width: containerSize,
        height: containerSize,
        child: Stack(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset("assets/munch.png", width: containerSize - MAIN_ICON_SIZE/2,)
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Opacity(
                  opacity: 0.85,
                  child: Card(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 35, top: 10, right: 35, bottom: 10),
                          child: Text("$total", style: TextStyle(
                              fontSize: 48
                          )
                          )
                      )
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                child: buildLevelCounter()
              )
            ]
        )
    );
  }

  Widget buildLevelCounter() {
    return Row(
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
    );
  }

  Widget buildMainGrid() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
                    SharedState.wipeGear();
                  }),
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: Icon(CustomIcons.skull),
                  )),
            )
          ],
        ),
      ],
    );
  }
}

