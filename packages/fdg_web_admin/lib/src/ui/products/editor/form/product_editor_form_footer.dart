import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';

class ProductEditorFormFooter extends StatelessWidget {
  static const _spacing = 10.0;

  final WidgetTapCallback onSubmitPressed;
  final EdgeInsets? padding;

  final bool isSmallLayout;

  const ProductEditorFormFooter({
    required this.onSubmitPressed,
    this.padding,
    this.isSmallLayout = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: FDGTheme().colors.lightGrey2,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: isSmallLayout ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          FDGPrimaryButton(
            FDGProductsLocaleKeys.editorConfirm.tr(), //Todo: rename this to 'Aanpassen' if the cubit indicates to
            icon: Icon(Icons.done),
            onTap: onSubmitPressed,
            padding: kIsWeb ? FDGTheme.defaultButtonInsetsWeb : null,
          ),
          SizedBox(
            width: _spacing,
          ),
          FDGSecondaryButton(
            FDGProductsLocaleKeys.editorCancel.tr(),
            padding: kIsWeb ? FDGTheme.defaultButtonInsetsWeb : null,
            onTap: (context) => Navigator.pop(context),
          )
        ].map((e) {
          final isButton = e is FDGPrimaryButton || e is FDGSecondaryButton;
          if (isButton & isSmallLayout) {
            return Expanded(child: e);
          } else {
            return e;
          }
        }).toList(),
      ),
    );
  }
}
