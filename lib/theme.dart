import 'package:flutter/material.dart';

// CORAL
Color coral = Color(0xffFF7F50);
Color coralWhite = Color(0xffDCE4E6);
Color coralDark = Color(0xff805B4E);
Color coralError = Color(0xffFF4252);
ThemeData coralTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      primaryColor: coral,
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme, coral),
      buttonColor: coral,
      accentColor: coralDark,
      scaffoldBackgroundColor: coralWhite,
      cardColor: Colors.white,
      textSelectionColor: coral,
      errorColor: coralError,
      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
      textSelectionHandleColor: coral,
      accentTextTheme: _buildTextTheme(base.accentTextTheme, coral),
      textTheme: _buildTextTheme(base.textTheme, coral));
}

// LightBlueish
Color viking = Color(0xffA8DADC);
Color vikingWhite = Color(0xffeeeeee);
Color vikingDark = Color(0xff457B9D);
Color vikingDarker = Color(0xff1D3557);
Color vikingError = Color(0xffE63946);
ThemeData vikingTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      primaryColor: viking,
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme, viking),
      buttonColor: viking,
      accentColor: vikingDark,
      scaffoldBackgroundColor: vikingWhite,
      cardColor: Colors.white,
      textSelectionColor: viking,
      errorColor: vikingError,
      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
      textSelectionHandleColor: viking,
      accentTextTheme: _buildTextTheme(base.accentTextTheme, viking),
      textTheme: _buildTextTheme(base.textTheme, vikingDark));
}

TextTheme _buildTextTheme(TextTheme base, Color color) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        displayColor: color,
        bodyColor: color,
      );
}
