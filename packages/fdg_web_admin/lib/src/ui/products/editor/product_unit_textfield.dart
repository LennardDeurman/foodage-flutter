import 'package:flutter/material.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/product_unit_localization.dart';
import 'package:fdg_web_admin/src/ui/products/editor/product_editor_dialog.dart';

class ProductUnitTextField extends StatefulWidget {
  final ProductUnit initialUnitValue;
  final double? initialValue;
  final Widget label;
  final String? hintText;

  const ProductUnitTextField({
    required this.initialUnitValue,
    required this.label,
    this.initialValue,
    this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductUnitTextFieldState();
}

class ProductUnitTextFieldState extends State<ProductUnitTextField> {
  static const _unitsMap = {
    ProductUnit.milliliters: [
      ProductUnit.milliliters,
      ProductUnit.liters,
    ],
    ProductUnit.liters: [
      ProductUnit.milliliters,
      ProductUnit.liters,
    ],
    ProductUnit.grams: [
      ProductUnit.kilograms,
      ProductUnit.grams,
    ],
    ProductUnit.kilograms: [
      ProductUnit.kilograms,
      ProductUnit.grams,
    ]
  };

  static const _conversionTypes = {
    ProductUnit.liters: ProductUnit.milliliters,
    ProductUnit.kilograms: ProductUnit.grams,
  };

  static const _conversionRates = {
    ProductUnit.liters: 1000.0,
    ProductUnit.kilograms: 1000.0,
  };

  late final ValueNotifier<ProductUnit> _selectedUnitNotifier = ValueNotifier(widget.initialUnitValue);

  late final TextEditingController _textEditingController = TextEditingController(
    text: widget.initialValue?.toString(),
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProductUnit>(
      valueListenable: _selectedUnitNotifier,
      builder: (context, selectedUnit, innerWidget) => FDGLabeledTextField(
        label: widget.label,
        textField: TextFormField(
          controller: _textEditingController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
              hintText: widget.hintText,
              suffixIcon: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  child: _UnitSuffix(
                    ProductUnitLocalization.convertShorthand(context, selectedUnit),
                  ),
                  onTap: () async {
                    final options = _unitsMap[selectedUnit]!;
                    final localizedUnits = options
                        .map(
                          (unit) => MapEntry<ProductUnit, String>(
                            unit,
                            ProductUnitLocalization.convertShorthand(context, unit),
                          ),
                        )
                        .toList();
                    final selectedMapEntry = localizedUnits.firstWhere(
                      (mapEntry) => mapEntry.key == selectedUnit,
                    );

                    final newSelectedOption = await showDialog<MapEntry<ProductUnit, String>>(
                      context: context,
                      builder: (context) => FDGOptionsDialog<MapEntry<ProductUnit, String>>(
                        options: localizedUnits,
                        value: selectedMapEntry,
                        label: (mapEntry) => ProductUnitLocalization.convert(context, mapEntry.key),
                      ),
                    );

                    if (newSelectedOption != null) {
                      _selectedUnitNotifier.value = newSelectedOption.key;
                    }
                  },
                ),
              )),
        ),
      ),
    );
  }

  ProductUnitResult get value => ProductUnitResult(
    value: _conversionRates[_selectedUnitNotifier.value] ?? 1.0 * double.parse(_textEditingController.text),
    type: _conversionTypes[_selectedUnitNotifier.value] ?? _selectedUnitNotifier.value,
  );
}

class _UnitSuffix extends StatelessWidget {
  static const _width = 50.0;
  static const _height = 40.0;

  final String unit;

  const _UnitSuffix(this.unit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: _height,
      width: _width,
      child: Container(
        child: Center(
          child: Text(
            unit,
            style: theme.textTheme.subtitle2!.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductUnitResult {
  final ProductUnit type;
  final double value;

  const ProductUnitResult({
    required this.value,
    required this.type,
  });
}
