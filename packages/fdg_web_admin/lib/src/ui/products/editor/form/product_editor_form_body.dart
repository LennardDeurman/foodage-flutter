import 'package:fdg_web_admin/src/ui/products/editor/form/product_editor_photo_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_web_admin/src/ui/products/editor/form/input_sections/product_editor_nutrients_info.dart';
import 'package:fdg_web_admin/src/ui/products/editor/form/input_sections/product_editor_quantity_info.dart';
import 'package:fdg_web_admin/src/ui/products/editor/form/product_editor_validation.dart';
import 'package:fdg_web_admin/src/ui/products/product_unit.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';

class ProductEditorFormBody extends StatelessWidget {
  static const _spacing = 20.0;

  const ProductEditorFormBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: _spacing,
      ),
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: FDGLabeledTextField(
                  label: Text(
                    FDGProductsLocaleKeys.editorFieldName.tr(),
                  ),
                  textField: TextFormField(
                    decoration: InputDecoration(
                      hintText: FDGProductsLocaleKeys.editorFieldNamePlaceholder.tr(),
                    ),
                    validator: (value) => ProductEditorValidation.validateName(
                      context,
                      value,
                    )
                        ? null
                        : '',
                  ),
                ),
              ),
              SizedBox(
                width: _spacing,
              ),
              ProductEditorPhotoPicker(
                onEditPressed: (context) {},
                onRemovePressed: (context) {},
                image: Container(), //
              ),
            ],
          ),
        ),
        SizedBox(
          height: _spacing,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: FDGLabeledTextField(
                label: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      FDGProductsLocaleKeys.editorFieldProductUrl.tr(),
                    ),
                    Spacer(),
                    _StoreSelectionButton.warning(context),
                  ],
                ),
                textField: TextFormField(
                  decoration: InputDecoration(
                    hintText: FDGProductsLocaleKeys.editorFieldProductUrlHint.tr(),
                  ),
                  validator: (value) => ProductEditorValidation.validateProductUrl(
                    context,
                    value,
                  )
                      ? null
                      : '',
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
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                  decoration: InputDecoration(
                    hintText: FDGProductsLocaleKeys.editorFieldPriceHint.tr(),
                  ),
                  validator: (value) => ProductEditorValidation.validatePrice(
                    context,
                    value,
                  )
                      ? null
                      : '',
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: _spacing,
        ),
        ProductEditorQuantityInfo(
          //TODO: Load parameter values from the cubit
          initialUnitValue: ProductUnit.milliliters,
          portionSizeInitialValue: 0.0,
          totalQuantityInitialValue: 0.0,
        ),
        SizedBox(
          height: _spacing,
        ),
        ProductEditorNutrientsInfo(),
        SizedBox(
          height: _spacing,
        ),
      ],
    );
  }
}

class _StoreSelectionButton extends StatelessWidget {
  static const _iconSize = 14.0;
  static const _fontSize = 10.0;
  static const _borderRadius = 10.0;
  static const _buttonInsets = EdgeInsets.symmetric(
    vertical: 4,
    horizontal: 8,
  );

  Widget _build(
    BuildContext context, {
    required Color color,
    required List<Widget> children,
    Color? textColor,
    bool filled = false,
  }) {
    final textStyle = Theme.of(context).textTheme.subtitle2!.copyWith(
          color: textColor ?? color,
          fontSize: _fontSize,
        );

    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: DefaultTextStyle(
          style: textStyle,
          child: IconTheme(
            data: IconThemeData(
              color: textColor ?? color,
              size: _iconSize,
            ),
            child: Container(
              padding: _buttonInsets,
              decoration: BoxDecoration(
                border: Border.all(
                  color: color,
                ),
                color: filled ? color : Colors.transparent,
                borderRadius: BorderRadius.circular(_borderRadius),
              ),
              child: Row(
                children: children,
              ),
            ),
          ),
        ),
        onTap: () => onPressed != null ? onPressed!(context) : null,
      ),
    );
  }

  final Widget? icon;
  final Widget text;
  final Color? color;
  final WidgetTapCallback? onPressed;

  _StoreSelectionButton({
    this.icon,
    this.color,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return _build(
      context,
      color: color ?? Theme.of(context).primaryColor,
      children: [
        if (icon != null)
          Padding(
            child: icon!,
            padding: EdgeInsets.only(
              right: 8,
            ),
          ),
        text,
      ],
    );
  }

  static Widget store(
    BuildContext context, {
    required String storeName,
    WidgetTapCallback? onPressed,
  }) {
    return _StoreSelectionButton(
      text: Text(storeName),
      onPressed: onPressed,
    );
  }

  static Widget warning(
    BuildContext context, {
    WidgetTapCallback? onPressed,
  }) {
    return _StoreSelectionButton(
      text: Text(
        FDGProductsLocaleKeys.editorStoreNotFound.tr(),
      ),
      icon: Icon(Icons.warning_rounded),
      onPressed: onPressed,
      color: FDGTheme().colors.orange,
    );
  }
}
