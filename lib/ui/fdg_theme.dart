
import 'package:flutter/material.dart';

class _Fonts {

  final montserrat = "Montserrat";
  final lato = "Lato";

}

class _Colors {

  final lightGrey =  Color.fromRGBO(186, 186, 186, 1);
  final grey = Color.fromRGBO(108, 108, 105, 1);
  final darkRed = Color.fromRGBO(157, 3, 3, 1);

}

class FDGTheme {

  static FDGTheme _instance;

  _Colors _colors;
  _Colors get colors => _colors;

  _Fonts _fonts;
  _Fonts get fonts => _fonts;

  factory FDGTheme() {
    if (_instance == null) _instance = FDGTheme._internal();
    return _instance;
  }

  FDGTheme._internal() {
    _fonts = _Fonts();
    _colors = _Colors();
  }

  Color get primarySwatch {
    return Colors.red;
  }

  String get appName {
    return "Foodage";
  }

  TextTheme get textTheme {
    final headlineStyle = TextStyle( //Appbar title
        fontFamily: FDGTheme().fonts.montserrat,
        fontSize: 20,
        fontWeight: FontWeight.w500
    );

    return TextTheme(
        button: TextStyle( //Default theme for most buttons
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: FDGTheme().fonts.montserrat
        ),
        headline1: headlineStyle,
        headline2: headlineStyle.copyWith(fontSize: 16),
        headline3: headlineStyle.copyWith(fontSize: 14),
        headline4: headlineStyle.copyWith(fontSize: 11),
        subtitle1: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: FDGTheme().fonts.lato,
            color: colors.lightGrey, //Color.fromRGBO(186, 186, 186, 1)
            fontSize: 11
        ),
        caption: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: fonts.montserrat,
            color: colors.grey, //Color.fromRGBO(108, 105, 105, 1)
            fontSize: 13
        )
    );
  }

  ThemeData get themeData {
    final textThemeForData = textTheme;
    return ThemeData(
      primarySwatch: primarySwatch,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: colors.darkRed,
      textTheme: textThemeForData,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: colors.darkRed,
              textStyle: textThemeForData.button
          )
      ),
    );
  }

}