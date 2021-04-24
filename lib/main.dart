import 'package:flutter/material.dart';
import 'package:foodage/data/service_locator.dart';
import 'ui/camera/camera_screen.dart';
import 'ui/fdg_theme.dart';

void main() async {
  await ServiceLocator.init();
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
