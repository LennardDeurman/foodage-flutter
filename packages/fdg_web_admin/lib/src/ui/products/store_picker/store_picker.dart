import 'package:fdg_common/fdg_common.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/models/store.dart';
import 'package:fdg_web_admin/src/ui/products/store_picker/cubit/store_picker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StorePicker extends StatelessWidget {
  final Store? initialValue;

  const StorePicker({
    Key? key,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorePickerCubit, ResourceState<List<Store>>>(
      builder: (context, state) {
        if (state.data != null) {
          return FDGOptionsDialog<Store>(
            options: state.data!,
            value: initialValue,
            label: (product) => product.name,
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
  }) {
    final storePickerCubit = context.read<StorePickerCubit>();
    showDialog<Store>(
      context: context,
      barrierDismissible: false,
      builder: (context) => BlocProvider.value(
        value: storePickerCubit,
        child: StorePicker(
          initialValue: initialValue,
        ),
      ),
    );
  }
}
