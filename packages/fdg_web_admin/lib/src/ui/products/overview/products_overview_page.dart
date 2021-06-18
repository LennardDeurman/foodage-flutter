import 'package:fdg_web_admin/src/ui/products/editor/product_editor.dart';
import 'package:flutter/material.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/fdg_web_admin_locale_keys.dart';
import 'package:fdg_web_admin/src/ui/widgets/fdg_web_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductsOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contextThemeData = Theme.of(context);
    final headlineTextStyle = contextThemeData.textTheme.headline1!.copyWith(
      color: Colors.white,
    );
    final subTitleTextStyle = contextThemeData.textTheme.headline2!.copyWith(
      color: FDGTheme().colors.lightGrey2,
      fontSize: 11,
    );
    return Scaffold(
      body: Stack(
        children: [
          Align(
            child: _AddProductButton(
              onPressed: (context) => ProductEditor.show(context),
            ),
            alignment: Alignment.center,
          ),
          FDGWebAppBar(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        FDGTheme().appName,
                        style: headlineTextStyle,
                      ),
                      Text(
                        FDGWebAdminLocaleKeys.productsOverviewTitle.tr(),
                        style: subTitleTextStyle,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddProductButton extends StatelessWidget {
  static const _buttonHeight = 35.0;

  final WidgetTapCallback onPressed;

  const _AddProductButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _buttonHeight,
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: FDGTheme().colors.mediumRed,
        ),
        child: FDGPrimaryButton(
          FDGWebAdminLocaleKeys.productsOverviewAddProduct.tr(),
          icon: Padding(
            child: Icon(Icons.add),
            padding: EdgeInsets.only(
              left: 10,
            ),
          ),
          onTap: onPressed,
        ),
      ),
    );
  }
}
