import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';
import 'package:fdg_web_admin/src/ui/products/editor/form/product_editor_form_body.dart';
import 'package:fdg_web_admin/src/ui/products/editor/form/product_editor_form_footer.dart';

class ProductEditorPage extends StatelessWidget {
  static const _topSpacing = 40.0;

  final GlobalKey<FormState> formKey;

  const ProductEditorPage({
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    final appBarTextStyle = Theme.of(context).textTheme.button!.copyWith(
          fontSize: 17,
        );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          FDGProductsLocaleKeys.editorTitle.tr(),
          style: appBarTextStyle,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: _topSpacing,
          ),
          Expanded(
            child: ProductEditorFormBody(),
          ),
          SafeArea(
            child: ProductEditorFormFooter(
              isSmallLayout: true,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 0,
              ),
              onSubmitPressed: (context) {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                }
              },
            ),
            bottom: true,
            top: false,
            minimum: EdgeInsets.only(
              bottom: 20,
            ),
          ),
        ],
      ),
    );
  }
}
