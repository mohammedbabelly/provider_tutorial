import 'package:flutter/material.dart';

class FontSizeNotifier extends ChangeNotifier {
  double fontSize1 = 22;
  double fontSize2 = 22;

  double get getFontize1 => fontSize1;
  double get getFontize2 => fontSize2;

  changeFontSize1(double newValue) {
    fontSize1 = newValue;
    notifyListeners();
  }

  changeFontSize2(double newValue) {
    fontSize2 = newValue;
    notifyListeners();
  }
}
