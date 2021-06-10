import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_web_admin/src/ui/products/editor/product_unit_textfield.dart';
import 'package:flutter/material.dart';

//TODO: Choose units for product, and add unit textfield

class ProductEditorDialog extends StatelessWidget {
  static const _maxHeight = 600.0;
  static const _maxWidth = 800.0;

  static const _spacing = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: _maxHeight,
          maxWidth: _maxWidth,
        ),
        child: FDGDialog(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Text(
                  FDGProductsLocaleKeys.editorTitle.tr(),
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline1,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: _spacing,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FDGLabeledTextField(
                        label: Text(
                          FDGProductsLocaleKeys.editorFieldName.tr(),
                        ),
                        textField: TextFormField(
                          decoration: InputDecoration(
                            hintText: FDGProductsLocaleKeys.editorFieldNamePlaceholder.tr(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _spacing,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: FDGLabeledTextField(
                              label: Text(
                                FDGProductsLocaleKeys.editorFieldProductUrl.tr(),
                              ),
                              textField: TextFormField(
                                decoration: InputDecoration(
                                  hintText: FDGProductsLocaleKeys.editorFieldProductUrlHint.tr(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: _spacing,
                          ),
                          Expanded(
                            child: FDGLabeledTextField(
                              label: Text(
                                FDGProductsLocaleKeys.editorFieldPrice.tr(),
                              ),
                              textField: TextFormField(
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                decoration: InputDecoration(
                                  hintText: FDGProductsLocaleKeys.editorFieldPriceHint.tr(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: _spacing,
                      ),
                      _QuantityInfoSection(),
                      SizedBox(
                        height: _spacing,
                      ),
                      _NutrientsInfoSection(),
                      SizedBox(
                        height: _spacing,
                      ),
                    ],
                  ),
                ),
              ),
              _BottomBar(),
            ],
          ),
        ),
      ),
      alignment: Alignment.center,
    );
  }

  static void show(BuildContext context) => showDialog(context: context, builder: (context) => ProductEditorDialog());
}

enum ProductUnit {
  milliliters,
  liters,
  grams,
  kilograms,
}

class _QuantityInfoSection extends StatelessWidget {
  static const _spacing = 20.0;

  const _QuantityInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ProductUnitTextField(
            label: Text(FDGProductsLocaleKeys.editorFieldTotalQuantity.tr()),
            hintText: FDGProductsLocaleKeys.editorFieldTotalQuantityHint.tr(),
            initialUnitValue: ProductUnit.milliliters, //TODO: Change to the cubit value
          ),
        ),
        SizedBox(
          width: _spacing,
        ),
        Expanded(
          child: ProductUnitTextField(
            label: Text(FDGProductsLocaleKeys.editorFieldPortionSize.tr()),
            hintText: FDGProductsLocaleKeys.editorFieldPortionSizeHint.tr(),
            initialUnitValue: ProductUnit.grams, //TODO: Change to the cubit value
          ),
        ),
        SizedBox(
          width: _spacing,
        ),
        Expanded(
          child: FDGLabeledTextField(
            label: Text(FDGProductsLocaleKeys.editorFieldUnits.tr()),
            textField: TextFormField(
              decoration: InputDecoration(),
            ),
          ),
        )
      ],
    );
  }
}

class _NutrientsInfoSection extends StatelessWidget {
  const _NutrientsInfoSection({Key? key}) : super(key: key);

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

class _NutrientInfoTextField extends StatelessWidget {
  static const _width = 60.0;
  static const _spacing = 10.0;

  final Widget label;
  final String initialValue;
  final String hintText;
  final ValueChanged<String> onChanged;

  const _NutrientInfoTextField({
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
            decoration: InputDecoration(
              hintText: hintText,
            ),
          )
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  static const _spacing = 10.0;

  const _BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: FDGTheme().colors.lightGrey2,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          FDGPrimaryButton(
            FDGProductsLocaleKeys.editorConfirm.tr(),
            icon: Icon(Icons.done),
            onTap: (context) {},
          ),
          SizedBox(
            width: _spacing,
          ),
          FDGSecondaryButton(
            FDGProductsLocaleKeys.editorCancel.tr(),
            onTap: (context) {},
          )
        ],
      ),
    );
  }
}
