import 'package:flutter/material.dart';
import 'package:foodage/ui/camera/camera_screen.dart';
import 'package:foodage/ui/fdg_theme.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final fdgTheme = FDGTheme();
    return MaterialApp(
      title: fdgTheme.appName,
      theme: fdgTheme.themeData,
      home: FoodCamera(),
    );
  }
}
