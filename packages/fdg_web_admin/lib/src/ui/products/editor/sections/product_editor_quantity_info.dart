import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';
import 'package:fdg_web_admin/src/product_unit_localization.dart';
import 'package:fdg_web_admin/src/ui/products/editor/product_editor_validation.dart';
import 'package:fdg_web_admin/src/ui/products/editor/product_unit_textfield.dart';
import 'package:fdg_web_admin/src/ui/products/product_unit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class ProductEditorQuantityInfo extends StatefulWidget { //TODO: Be consise with the ProductEditorNutrientsInfo and load values directly from cubit
  final ProductUnit initialUnitValue;
  final double? totalQuantityInitialValue;
  final double? portionSizeInitialValue;

  const ProductEditorQuantityInfo({
    required this.initialUnitValue,
    this.totalQuantityInitialValue,
    this.portionSizeInitialValue,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductEditorQuantityInfoState();
}

class ProductEditorQuantityInfoState extends State<ProductEditorQuantityInfo> {
  static const _spacing = 20.0;

  late final _unitValueNotifier = ValueNotifier<ProductUnit>(widget.initialUnitValue);

  GlobalKey<ProductUnitTextFieldState> _totalQuantityFieldKey = GlobalKey<ProductUnitTextFieldState>();

  GlobalKey<ProductUnitTextFieldState> _portionFieldKey = GlobalKey<ProductUnitTextFieldState>();


  @override
  void initState() {
    super.initState();

    _unitValueNotifier.addListener(() {
      _totalQuantityFieldKey.currentState?.resetToUnit(_unitValueNotifier.value);
      _portionFieldKey.currentState?.resetToUnit(_unitValueNotifier.value);
      //TODO: Update the cubit when the value changes
    });
  }

  void _selectUnitType() async {
    final newSelectedProductUnit = await showDialog<ProductUnit>(
      context: context,
      builder: (context) => FDGOptionsDialog<ProductUnit>(
        options: [ProductUnit.milliliters, ProductUnit.grams],
        value: _unitValueNotifier.value,
        label: (productUnit) => ProductUnitLocalization.convert(context, productUnit),
      ),
    );
    if (newSelectedProductUnit != null) {
        _unitValueNotifier.value = newSelectedProductUnit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProductUnit>(
      valueListenable: _unitValueNotifier,
      builder: (context, selectedProductUnit, innerWidget) => Row(
        children: [
          Expanded(
            child: ProductUnitTextField(
              key: _totalQuantityFieldKey,
              label: Text(FDGProductsLocaleKeys.editorFieldTotalQuantity.tr()),
              hintText: FDGProductsLocaleKeys.editorFieldTotalQuantityHint.tr(),
              initialUnitValue: selectedProductUnit,
              initialValue: widget.totalQuantityInitialValue,
              validator: (value) => ProductEditorValidation.validateQuantityValue(context, value) ? null : '',
              onChanged: (value) {} //TODO: Update the cubit when the value changes
            ),
          ),
          SizedBox(
            width: _spacing,
          ),
          Expanded(
            child: ProductUnitTextField(
              key: _portionFieldKey,
              label: Text(FDGProductsLocaleKeys.editorFieldPortionSize.tr()),
              hintText: FDGProductsLocaleKeys.editorFieldPortionSizeHint.tr(),
              initialUnitValue: selectedProductUnit,
              initialValue: widget.portionSizeInitialValue,
              validator: (value) => ProductEditorValidation.validateQuantityValue(context, value) ? null : '',
              onChanged: (value) {} //TODO: Update the cubit when the value changes
            ),
          ),
          SizedBox(
            width: _spacing,
          ),
          Expanded(
            child: FDGLabeledTextField(
              label: Text(FDGProductsLocaleKeys.editorFieldUnits.tr()),
              textField: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                ],
                decoration: InputDecoration(
                    hintText: ProductUnitLocalization.convert(context, _unitValueNotifier.value),
                    hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: FDGTheme().colors.darkGrey,
                    ),
                ),
                onTap: _selectUnitType,
                enableInteractiveSelection: false,
                showCursor: false,
              ),
            ),
          )
        ],
      ),
    );
  }
}
