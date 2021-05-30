import 'package:fdg_camera/fdg_camera.dart';
import 'package:flutter/material.dart';
import 'package:fdg_ui/fdg_ui.dart';

void main() async {
  FDGCamera.initialize();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final fdgTheme = FDGTheme();
    return MaterialApp(
      title: fdgTheme.appName,
      theme: fdgTheme.themeData,
      home: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: FDGPrimaryButton(
                  'Open camera',
                  onTap: (context) => FDGCamera.show(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
