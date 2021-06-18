import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_web_admin/src/ui/products/editor/form/product_editor_form_body.dart';
import 'package:fdg_web_admin/src/ui/products/editor/form/product_editor_form_footer.dart';
import 'package:flutter/material.dart';

class ProductEditorDialog extends StatelessWidget {
  static const _maxHeight = 700.0;
  static const _maxWidth = 850.0;

  final GlobalKey<FormState> formKey;

  const ProductEditorDialog({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: _maxHeight,
        maxWidth: _maxWidth,
      ),
      child: FDGDialog(
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              _Header(),
              ProductEditorFormBody(),
              ProductEditorFormFooter(
                onSubmitPressed: (context) {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                  }
                },
              ),
            ],
          ),
          padding: EdgeInsets.only(
            top: 15,
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 20,
      ),
      child: Text(
        FDGProductsLocaleKeys.editorTitle.tr(), //TODO: Rename editor title if cubit indicator edit product
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
