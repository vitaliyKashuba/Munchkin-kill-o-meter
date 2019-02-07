import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../layout_util.dart';

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
    const double padding = 6;
    double cellSize = min(MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height) / 3 - (padding * 3);

//    print('cell size: $cellSize');

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 90, maxHeight: 90, minHeight: 70, minWidth: 70
      ),
      child: InkWell(
          highlightColor: Colors.deepOrangeAccent[200],
          onTap: widget.onTap,
          onDoubleTap: widget.onDoubleTap,
          onLongPress: widget.onLongTap,
          child: Padding(
            padding: const EdgeInsets.all(padding),
            child: Ink(
              width: cellSize,
              height: cellSize,
                color: widget.color,
                child: widget.child == null ? Container() : widget.child),
          )),
    );
  }
}