import 'package:flutter/material.dart';

const Color tashGrey = Color(0xffb4b8ab);
const Color tRoyalBlue = Color(0xff0A2463);
const Color tCelestialBlue = Color(0xff95C3E3);
const Color tCelestialBlue2 = Color(0xff7AA0BA);
const Color tWhite = Color(0xffFFFAFF);
const Color tCherry = Color(0xffD8315B);
const Color tEerieBlack = Color(0xff1E1B18);
final ThemeData t = _buildBrightTheme();
ThemeData _buildBrightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: tCelestialBlue,
    errorColor: tCherry,
    textSelectionColor: tRoyalBlue,
    disabledColor: tashGrey,
    iconTheme: IconThemeData(color: tRoyalBlue),
    buttonTheme: base.buttonTheme.copyWith(
        buttonColor: tRoyalBlue,
        disabledColor: tashGrey,
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme.light().copyWith(primary: tRoyalBlue)),
    scaffoldBackgroundColor: tWhite,
    textTheme: _buildbrightTextTheme(base.textTheme),
    primaryTextTheme: _buildbrightTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildbrightTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(color: tWhite),
    hintColor: tashGrey,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: tWhite),
      textTheme: TextTheme(
          title: TextStyle(
        color: tWhite,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      )),
    ),
  );
}

TextTheme _buildbrightTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
      )
      .apply(
        displayColor: tRoyalBlue,
        bodyColor: tRoyalBlue,
        fontFamily: 'Black_label',
      );
}
