import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_ui/fdg_ui.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';
import 'package:flutter/material.dart';

class ProductEditorPhotoPicker extends StatelessWidget {
  final Widget? image;
  final WidgetTapCallback onEditPressed;
  final WidgetTapCallback onAddPressed;

  const ProductEditorPhotoPicker({
    Key? key,
    this.image,
    required this.onEditPressed,
    required this.onAddPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          FDGPhotoContainer(
            content: Container(
              child: Stack(
                children: [
                  image!,
                  Container(
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
              ),
            ),
            actionButtons: [
              FDGBadgeActionButton(
                color: FDGTheme().colors.darkRed,
                icon: Icon(Icons.add),
                onPressed: onAddPressed,
                buttonInnerMargin: 8,
              ),
              FDGBadgeActionButton(
                color: FDGTheme().colors.orange,
                icon: Icon(Icons.edit),
                onPressed: onEditPressed,
                buttonInnerMargin: 8,
              ),
            ],
          ),
          Positioned(
            left: 15,
            bottom: 15,
            child: Text(
              '10',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Colors.white,
                  ),
            ),
          )
        ],
      );
    }
    return _ProductEditorPhotoPickerPlaceholder(
      onPressed: onEditPressed,
    );
  }
}

class _ProductEditorPhotoPickerPlaceholder extends StatelessWidget {
  static const _radius = 12.0;
  static const _dashPattern = [4.0, 1.0];
  static const _spacing = 12.0;
  static const _strokeWidth = 0.5;

  final WidgetTapCallback? onPressed;

  const _ProductEditorPhotoPickerPlaceholder({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle2!.copyWith(
          color: FDGTheme().colors.darkRed,
        );

    return Stack(
      children: [
        Positioned.fill(
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(_radius),
            dashPattern: _dashPattern,
            color: FDGTheme().colors.darkRed,
            strokeWidth: _strokeWidth,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        ClipRRect(
          child: Material(
            child: InkWell(
              child: FDGRatio(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      color: FDGTheme().colors.darkRed,
                    ),
                    SizedBox(
                      height: _spacing,
                    ),
                    Text(
                      FDGProductsLocaleKeys.editorPhotoPickerSelect.tr(),
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              onTap: () => onPressed != null ? onPressed!(context) : null,
            ),
          ),
          borderRadius: BorderRadius.circular(_radius),
        ),
      ],
    );
  }
}

class ProductPickerPhotoPreviewDialog extends StatelessWidget {
  const ProductPickerPhotoPreviewDialog({Key? key}) : super(key: key);

  static void show(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
