import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';
import 'package:fdg_web_admin/src/ui/products/product_unit.dart';
import 'package:fdg_web_admin/src/ui/products/product_unit_textfield.dart';
import 'package:flutter/material.dart';

//TODO: Connect with cubit

class ProductEditorPortionInfo extends StatelessWidget {
  const ProductEditorPortionInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTextStyle(
      style: theme.textTheme.subtitle2!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            FDGProductsLocaleKeys.editorPortionSizes.tr(),
          ),
          SizedBox(height: 10,),
          Wrap(
            spacing: 20.0,
            runSpacing: 8.0,
            children: [
              ProductEditorPortionInput(name: FDGProductsLocaleKeys.editorPortionSizeDefault.tr(), isEditable: false,),
              RawMaterialButton(
                constraints: BoxConstraints.tight(Size(36, 36)),
                onPressed: () {

                },
                child: Icon(Icons.add, color: Colors.white, size: 18),
                shape: CircleBorder(),
                elevation: 0.0,
                fillColor: FDGTheme().colors.mediumRed,
              ),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}

class ProductEditorPortionInput extends StatelessWidget {
  static const _borderRadius = 8.0;
  static const _portionNameFieldWidth = 120.0;
  static const _portionUnitFieldWidth = 90.0;

  final bool isEditable;
  final String? name;

  const ProductEditorPortionInput({
    this.name,
    this.isEditable = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputDecorationTheme = theme.inputDecorationTheme.copyWith(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide.none,
      ),
      filled: false,
    );
    return Theme(
      data: theme.copyWith(
        inputDecorationTheme: inputDecorationTheme,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
                color: FDGTheme().colors.lightGrey3,
                borderRadius: BorderRadius.circular(_borderRadius)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: FDGTheme().colors.lightGrey2,
                      ),
                    ),
                  ),
                  width: _portionNameFieldWidth,
                  child: TextFormField(
                    initialValue: name,
                    enabled: isEditable,
                    decoration: InputDecoration(
                      hintText: FDGProductsLocaleKeys.editorPortionHint.tr(),
                      filled: false,
                    ),
                  ),
                ),
                Container(
                  width: _portionUnitFieldWidth,
                  child: ProductUnitTextField(
                    initialUnitValue: ProductUnit.milliliters,
                    initialValue: 0.0,
                  ),
                )
              ],
            ),
          ),
          if (isEditable) Positioned(
            top: -10,
            right: 15,
            child: FDGBadgeActionButton(
              color: theme.primaryColor,
              icon: Icon(Icons.close),
              onPressed: (context) {},
            ),
          )
        ],
      ),
    );
  }
}
