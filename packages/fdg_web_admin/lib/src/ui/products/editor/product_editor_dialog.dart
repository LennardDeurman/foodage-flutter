import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';
import 'package:fdg_web_admin/src/ui/products/editor/sections/product_editor_quantity_info.dart';
import 'package:fdg_web_admin/src/ui/products/editor/product_editor_validation.dart';
import 'package:fdg_web_admin/src/ui/products/editor/sections/product_editor_nutrients_info.dart';
import 'package:fdg_web_admin/src/ui/products/product_unit.dart';

class ProductEditorDialog extends StatefulWidget {
  static void show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => ProductEditorDialog(),
      );

  @override
  State<StatefulWidget> createState() => _ProductEditorDialogState();
}

class _ProductEditorDialogState extends State<ProductEditorDialog> {
  static const _maxHeight = 700.0;
  static const _maxWidth = 850.0;

  static const _spacing = 20.0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
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
                    style: Theme.of(context).textTheme.headline1,
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
                            validator: (value) => ProductEditorValidation.validateName(
                              context,
                              value,
                            ) ? null : 'This should not be visible',
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
                                  ) ? null : '',
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
                                  validator: (value) => ProductEditorValidation.validatePrice(
                                    context,
                                    value,
                                  ) ? null : '',
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
                    ),
                  ),
                ),
                _BottomBar(onSubmitPressed: (context) {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                }),
              ],
            ),
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  static const _spacing = 10.0;

  final WidgetTapCallback onSubmitPressed;

  const _BottomBar({required this.onSubmitPressed, Key? key}) : super(key: key);

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
            onTap: onSubmitPressed,
          ),
          SizedBox(
            width: _spacing,
          ),
          FDGSecondaryButton(
            FDGProductsLocaleKeys.editorCancel.tr(),
            onTap: (context) => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
