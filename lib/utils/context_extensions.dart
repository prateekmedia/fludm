import 'package:flutter/material.dart';

extension Context on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  Color get primaryColor => theme.primaryColor;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  back() => Navigator.of(this).pop();
}
