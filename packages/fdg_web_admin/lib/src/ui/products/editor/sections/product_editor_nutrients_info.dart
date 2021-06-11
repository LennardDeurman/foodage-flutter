import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';
import 'package:fdg_web_admin/src/ui/products/editor/product_editor_validation.dart';
import 'package:flutter/material.dart';

class ProductEditorNutrientsInfo extends StatelessWidget {
  const ProductEditorNutrientsInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme
        .of(context)
        .textTheme
        .subtitle2!;
    final nutrientLabelStyle = defaultTextStyle.copyWith(
      fontSize: 9,
    );
    final subtitleStyle = defaultTextStyle.copyWith(
      color: FDGTheme().colors.lightGrey1,
    );
    return DefaultTextStyle(
      style: nutrientLabelStyle,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                FDGProductsLocaleKeys.nutritionalValue.tr(),
                style: defaultTextStyle,
              ),
              Text(
                FDGProductsLocaleKeys.unitPer100g.tr(),
                style: subtitleStyle,
              ),
            ],
          ),
          Spacer(),
          /*
          _NutrientInfoTextField(
            label: label,
            initialValue: initialValue,
            hintText: hintText,
            onChanged: onChanged,
          ),
          SizedBox(width: 10,),
          _NutrientInfoTextField(
            label: label,
            initialValue: initialValue,
            hintText: hintText,
            onChanged: onChanged,
          ),
          SizedBox(width: 10,),
          _NutrientInfoTextField(
            label: label,
            initialValue: initialValue,
            hintText: hintText,
            onChanged: onChanged,
          ),
          SizedBox(width: 10,),
          _NutrientInfoTextField(
            label: label,
            initialValue: initialValue,
            hintText: hintText,
            onChanged: onChanged,
          ), */
        ],
      ),
    );
  }
}

class ProductEditorNutrientTextField extends StatelessWidget {
  static const _width = 60.0;
  static const _spacing = 10.0;

  final Widget label;
  final String initialValue;
  final String hintText;
  final ValueChanged<String> onChanged;

  const ProductEditorNutrientTextField({
    required this.label,
    required this.initialValue,
    required this.hintText,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          label,
          SizedBox(
            height: _spacing,
          ),
          TextFormField(
            initialValue: initialValue,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            validator: (value) => ProductEditorValidation.validateNutrient(context, value,) ? null : '',
            decoration: InputDecoration(
              hintText: hintText,
            ),
          )
        ],
      ),
    );
  }
}