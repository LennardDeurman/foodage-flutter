import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';
import 'package:fdg_web_admin/src/ui/products/editor/form/product_editor_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductEditorNutrientsInfo extends StatelessWidget {
  static const _spacing = 10.0;

  const ProductEditorNutrientsInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.subtitle2!;
    final nutrientLabelStyle = defaultTextStyle.copyWith(
      fontSize: 9,
    );
    final subtitleStyle = defaultTextStyle.copyWith(
      color: FDGTheme().colors.lightGrey1,
    );
    return DefaultTextStyle(
      style: nutrientLabelStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                FDGProductsLocaleKeys.nutritionalValue.tr(),
                style: defaultTextStyle,
              ),
              Spacer(),
              Text(
                FDGProductsLocaleKeys.unitPer100g.tr(), //TODO: This value should change when cubit unit changes
                style: subtitleStyle.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              ProductEditorNutrientTextField(
                label: Text(
                  FDGProductsLocaleKeys.nutrientCarbs.tr(),
                ),
                onChanged: (value) {},
              ),
              SizedBox(
                width: _spacing,
              ),
              ProductEditorNutrientTextField(
                label: Text(
                  FDGProductsLocaleKeys.nutrientProtein.tr(),
                ),
                onChanged: (value) {},
              ),
              SizedBox(
                width: _spacing,
              ),
              ProductEditorNutrientTextField(
                label: Text(
                  FDGProductsLocaleKeys.nutrientFats.tr(),
                ),
                onChanged: (value) {},
              ),
              SizedBox(
                width: _spacing,
              ),
              ProductEditorNutrientTextField(
                label: Text(
                  FDGProductsLocaleKeys.nutrientEnergy.tr(),
                ),
                onChanged: (value) {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProductEditorNutrientTextField extends StatelessWidget {
  static const _width = 70.0;
  static const _spacing = 10.0;

  final Widget label;
  final double initialValue;
  final String? hintText;
  final ValueChanged<String> onChanged;

  const ProductEditorNutrientTextField({
    required this.label,
    required this.onChanged,
    this.hintText,
    this.initialValue = 0.0,
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
            initialValue: initialValue.toString(),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
            ],
            validator: (value) => ProductEditorValidation.validateNutrient(
              context,
              value,
            )
                ? null
                : '',
            decoration: InputDecoration(
              hintText: hintText,
            ),
          )
        ],
      ),
    );
  }
}
