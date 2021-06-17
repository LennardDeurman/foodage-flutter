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
                onEditPressed: (context) {

                },
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
