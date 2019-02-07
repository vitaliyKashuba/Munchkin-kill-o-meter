import 'dart:math';

import 'package:flutter/material.dart';

class LayoutUtil {

  static double getScreenRatio(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return max(height/width, width/height);
  }

}