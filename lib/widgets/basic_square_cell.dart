import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../layout_util.dart';

const double _padding = 6;
const double _maxSize = 90;
const double _minSize = 70;

/// Used to wrap content, that should be aligned as Counter cells
class BasicSquareCell extends StatefulWidget {
  final Widget child;
  final Function() onTap, onDoubleTap, onLongTap;
  final Color color;

  BasicSquareCell(
      {this.child, this.onTap, this.onDoubleTap, this.onLongTap, this.color}) {}

  static double getMaxCellSize() => _maxSize + _padding * 2;

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
    double cellSize = min(MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height) / 3 - (_padding * 3);

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: _maxSize, maxHeight: _maxSize, minHeight: _minSize, minWidth: _minSize
      ),
      child: InkWell(
          highlightColor: Colors.deepOrangeAccent[200],
          onTap: widget.onTap,
          onDoubleTap: widget.onDoubleTap,
          onLongPress: widget.onLongTap,
          child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Ink(
              width: cellSize,
              height: cellSize,
                color: widget.color,
                child: widget.child == null ? Container() : widget.child),
          )),
    );
  }
}