import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_app/fdg_app_locale_keys.dart';
import 'package:fdg_camera/fdg_camera.dart';
import 'package:flutter/material.dart';
import 'package:fdg_ui/fdg_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FDGCamera.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {

  static const _localizationAssetPath =  'assets/translations';

  @override
  Widget build(BuildContext context) {
    final fdgTheme = FDGTheme();
    return EasyLocalization(
      child: Builder(
        builder: (context) => MaterialApp(
          title: fdgTheme.appName,
          theme: fdgTheme.themeData,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: Scaffold(
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: FDGPrimaryButton(
                      FDGAppLocaleKeys.demoOpenCamera.tr(),
                      onTap: (context) => FDGCamera.show(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      supportedLocales: [
        Locale('nl'),
      ],
      path: _localizationAssetPath,
    );
  }
}
