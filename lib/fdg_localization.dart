import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FDGLocalization extends StatelessWidget {

  static const _localizationAssetPath =  'assets/translations';

  static Future<void> ensureInitialized() => EasyLocalization.ensureInitialized();

  final WidgetBuilder builder;

  const FDGLocalization ({ Key? key, required this.builder }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      child: Builder(
        builder: builder,
      ),
      supportedLocales: [
        Locale('nl'),
      ],
      path: _localizationAssetPath,
    );
  }
}