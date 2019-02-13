import 'dart:math';

import 'package:flutter/material.dart';

import './widgets/basic_square_cell.dart';

class LayoutUtil {

  static const double MAIN_PADDING = 20;

  static double getMainPadding() => MAIN_PADDING;

  static double calculateTabSize(BuildContext context) {
    double cellSize = BasicSquareCell.getMaxCellSize();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    MediaQuery.of(context).size.longestSide;
    double bigSide = max(width, height);
    double appBarCorrection = 40;
    return bigSide - (3 * cellSize + 2 * MAIN_PADDING + appBarCorrection);
  }

}