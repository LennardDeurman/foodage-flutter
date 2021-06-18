library fdg_web_admin;

import 'package:fdg_web_admin/src/ui/products/overview/products_overview_page.dart';
import 'package:flutter/material.dart';


class FDGWebAdmin extends StatelessWidget {

  const FDGWebAdmin ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elevatedButtonThemeStyle = Theme.of(context).elevatedButtonTheme.style ?? ButtonStyle();
    final outlinedButtonThemeStyle = Theme.of(context).outlinedButtonTheme.style ?? ButtonStyle();
    final buttonPadding = EdgeInsets.symmetric(
      vertical: 14,
      horizontal: 20,
    );
    final themeData = Theme.of(context).copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: elevatedButtonThemeStyle.copyWith(
          padding: MaterialStateProperty.all(buttonPadding),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: outlinedButtonThemeStyle.copyWith(
            padding: MaterialStateProperty.all(buttonPadding),
          )
      ),
    );

    return Theme(
      data: themeData,
      child: ProductsOverviewPage(),
    );
  }

}
