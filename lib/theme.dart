import 'package:flutter/material.dart';
class ThisTheme {
  bool darkState;
  ThisTheme({this.darkState});

  void switchTheme() => darkState ? darkState = false : darkState = true;
  ThemeData getTheme() => darkState ? ThemeData.dark() : ThemeData.light();
}
