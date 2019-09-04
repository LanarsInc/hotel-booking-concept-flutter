import 'package:flutter/material.dart';

class HotelConceptThemeProvider {
  static ThemeData get() {
    return ThemeData(
      primaryColorLight: Color(0xff5b626b),
      hintColor: Color(0xffbfc2c5),
      accentColor: Color(0xff006be3),
      unselectedWidgetColor: Color(0x191a86ff),
      indicatorColor: Color(0x33ffffff),
      highlightColor: Color(0xffe8f2ff),
      disabledColor: Color(0xffffbb76),
      hoverColor: Color(0x19000000),
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      textTheme: TextTheme(
          display1: TextStyle(
            color: Color(0x60717171),
          ),
          display2: TextStyle(
            fontSize: 20,
            color: Color(0xff7e848b),
          ),
          display3: TextStyle(
            color: Color(0xff2cac97),
          ),
          display4: TextStyle(
            color: Color(0xffededed),
          )),
    );
  }
}
