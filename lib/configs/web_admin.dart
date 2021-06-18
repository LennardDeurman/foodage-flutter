import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_app/fdg_localization.dart';
import 'package:fdg_web_admin/fdg_web_admin.dart';
import 'package:flutter/material.dart';
import 'package:fdg_ui/fdg_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FDGLocalization.ensureInitialized();
  runApp(WebAdminApp());
}

class WebAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fdgTheme = FDGTheme();
    return FDGLocalization(
      builder: (context) {
        return MaterialApp(
          title: fdgTheme.appName,
          theme: fdgTheme.themeData,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: FDGWebAdmin()
        );
      },
    );
  }
}
