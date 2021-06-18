import 'package:fdg_web_admin/src/ui/products/editor/appearance/product_editor_dialog.dart';
import 'package:fdg_web_admin/src/ui/products/editor/appearance/product_editor_page.dart';
import 'package:fdg_web_admin/src/ui/products/store_picker/cubit/store_picker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO: Create a full-screen dialog, and implement responsive sizing
//TODO: Add image input

class ProductEditor extends StatefulWidget {
  static void show(BuildContext context) {
    final storePickerCubit = context.read<StorePickerCubit>();
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: storePickerCubit),
          ],
          child: Builder(
            builder: (context) => ProductEditor(),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => ProductEditorState();
}

class ProductEditorState extends State<ProductEditor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Builder(builder: (context) {
          if (screenWidth > 500) {
            //Return dialog layout
            return ProductEditorDialog(
              formKey: _formKey,
            );
          } else {
            return ProductEditorPage(
              formKey: _formKey,
            );
          }
        }),
        alignment: Alignment.center,
      ),
    );
  }
}
