import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _Colors {
  final lightGrey3 = Color.fromRGBO(241, 241, 241, 1);
  final lightGrey2 = Color.fromRGBO(220, 220, 220, 1);
  final lightGrey1 = Color.fromRGBO(186, 186, 186, 1);
  final grey = Color.fromRGBO(108, 108, 105, 1);
  final darkGrey = Color.fromRGBO(95, 95, 95, 1);
  final darkRed = Color.fromRGBO(157, 3, 3, 1);
  final mediumRed = Color.fromRGBO(180, 3, 3, 1);
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
      textStyle: TextStyle(
        //Appbar title
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: _colors.darkGrey,
      ),
    );


    return TextTheme(
      button: GoogleFonts.montserrat(
        textStyle: TextStyle(
          //Default theme for most buttons
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      headline1: headlineStyle,
      headline2: headlineStyle.copyWith(fontSize: 16),
      headline3: headlineStyle.copyWith(fontSize: 14),
      headline4: headlineStyle.copyWith(fontSize: 11),
      subtitle1: GoogleFonts.lato( //This is apparently used as default for textformfieldd
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: colors.darkGrey, //Color.fromRGBO(186, 186, 186, 1)
          fontSize: 12,
        ),
      ),
      subtitle2: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: colors.darkGrey,
          fontSize: 12,
        ),
      ),
      caption: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: colors.grey, //Color.fromRGBO(108, 105, 105, 1)
          fontSize: 14,
        ),
      ),
    );
  }

  ThemeData get themeData {
    final textThemeForData = textTheme;
    return ThemeData(
      primarySwatch: primarySwatch,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: colors.darkRed,
      textTheme: textThemeForData,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: _colors.lightGrey3,
        filled: true,
        hintStyle: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: colors.lightGrey1,
            fontSize: 12,
          ),
        ),
        errorMaxLines: 1,
        errorStyle: TextStyle(fontSize: 0.1, color: Colors.transparent),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.mediumRed),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.mediumRed),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        )
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
