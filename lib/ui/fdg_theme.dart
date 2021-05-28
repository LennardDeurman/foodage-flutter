import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _Colors {

  final lightGrey2 = Color.fromRGBO(220, 220, 220, 1);
  final lightGrey1 =  Color.fromRGBO(186, 186, 186, 1);
  final grey = Color.fromRGBO(108, 108, 105, 1);
  final darkGrey = Color.fromRGBO(95, 95, 95, 1);
  final darkRed = Color.fromRGBO(157, 3, 3, 1);
  final orange = Color.fromRGBO(255, 165, 0, 1);

}

class FDGTheme {

  static FDGTheme? _instance;

  late _Colors _colors;
  _Colors get colors => _colors;


  factory FDGTheme() {
    if (_instance == null) _instance = FDGTheme._internal();
    return _instance!;
  }

  FDGTheme._internal() {
    _colors = _Colors();
  } 

  MaterialColor get primarySwatch {
    return Colors.red;
  }

  String get appName {
    return "Foodage";
  }

  TextTheme get textTheme {
    final headlineStyle = GoogleFonts.montserrat(
      textStyle: TextStyle( //Appbar title
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: _colors.darkGrey
      )
    );

    return TextTheme(
        button: GoogleFonts.montserrat(
          textStyle: TextStyle( //Default theme for most buttons
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
          )
        ),
        headline1: headlineStyle,
        headline2: headlineStyle.copyWith(fontSize: 16),
        headline3: headlineStyle.copyWith(fontSize: 14),
        headline4: headlineStyle.copyWith(fontSize: 11),
        subtitle1: GoogleFonts.lato(
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: colors.lightGrey1, //Color.fromRGBO(186, 186, 186, 1)
              fontSize: 12
          ),
        ),
        caption: GoogleFonts.montserrat(
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: colors.grey, //Color.fromRGBO(108, 105, 105, 1)
              fontSize: 14
          )
        )
    );
  }

  ThemeData get themeData {
    final textThemeForData = textTheme;
    return ThemeData(
      primarySwatch: primarySwatch,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: colors.darkRed,
      textTheme: textThemeForData
    );
  }

}