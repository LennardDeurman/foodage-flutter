import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_common/fdg_common.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';
import 'package:fdg_web_admin/src/models/store.dart';
import 'package:fdg_web_admin/src/ui/products/store_picker/cubit/store_picker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorePicker extends StatelessWidget {
  final Store? initialValue;
  final bool shouldShowAlert;

  const StorePicker({
    Key? key,
    this.shouldShowAlert = false,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorePickerCubit, ResourceState<List<Store>>>(
      builder: (context, state) {
        if (state.data != null) {
          final theme = Theme.of(context);
          return FDGOptionsDialog<Store>(
            options: state.data!,
            value: initialValue,
            label: (product) => product.name,
            header: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (shouldShowAlert) _StorePickerInlineAlert(),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: FDGProductsLocaleKeys.storePickerSearchHint.tr(),
                      prefixIcon: Icon(
                        Icons.search,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            footer: FDGOptionsAddTile(
              label: Text(
                FDGProductsLocaleKeys.storePickerAddNew.tr(),
              ),
              icon: Icon(Icons.add),
            ),
          );
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {
        //TODO: Implement listenWhen, and listener for errors
      },
    );
  }

  static void show(
    BuildContext context, {
    Store? initialValue,
    bool shouldShowAlert = false,
  }) {
    final storePickerCubit = context.read<StorePickerCubit>();
    showDialog<Store>(
      context: context,
      barrierDismissible: false,
      builder: (context) => BlocProvider.value(
        value: storePickerCubit,
        child: StorePicker(
          shouldShowAlert: shouldShowAlert,
          initialValue: initialValue,
        ),
      ),
    );
  }
}

class _StorePickerInlineAlert extends StatelessWidget {

  static const _padding = EdgeInsets.all(15);
  static const _innerSpacing = 5.0;
  static const _borderRadius = 10.0;
  static const _spacing = 10.0;

  const _StorePickerInlineAlert ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: _spacing,
      ),
      padding: _padding,
      decoration: BoxDecoration(
        color: FDGTheme().colors.lightGrey3,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            FDGProductsLocaleKeys.storePickerInfoTitle.tr(),
            style: theme.textTheme.headline3!,
          ),
          SizedBox(
            height: _innerSpacing,
          ),
          Text(
            FDGProductsLocaleKeys.storePickerInfoDescription.tr(),
            style: theme.textTheme.subtitle1!.copyWith(
              color: FDGTheme().colors.grey.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

}
