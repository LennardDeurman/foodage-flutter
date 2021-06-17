import 'package:flutter/material.dart';
import 'package:fdg_common/fdg_common.dart';
import 'package:fdg_ui/fdg_ui.dart';

class FDGPhotoContainer extends StatelessWidget {
  final WidgetTapCallback? onRemovePressed;
  final WidgetTapCallback? onEditPressed;
  final double borderRadius;
  final Widget content;

  static const _backgroundColor = Color.fromRGBO(100, 100, 100, 1);

  FDGPhotoContainer({
    required this.content,
    this.borderRadius = 10,
    this.onRemovePressed,
    this.onEditPressed,
  });

  Widget _actionButtonRemove(BuildContext context) => FDGBadgeActionButton(
    color: Theme.of(context).primaryColor,
    icon: Icon(Icons.close),
    onPressed: onRemovePressed!,
  );

  Widget _actionButtonEdit(BuildContext context) => FDGBadgeActionButton(
    color: FDGTheme().colors.orange,
    icon: Icon(Icons.edit),
    onPressed: onEditPressed!,
    buttonInnerMargin: 8,
  );

  List<Widget> _actionButtons(BuildContext context) => <Widget>[
    if (onEditPressed != null) _actionButtonEdit(context),
    if (onRemovePressed != null) _actionButtonRemove(context),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: FDGRatio(
              child: content,
            ),
          ),
        ),
        Positioned(
          top: -5,
          right: 10,
          child: Row(
            children: _actionButtons(context)
                .intersperse(
              SizedBox(
                width: 8,
              ),
            )
                .toList(),
          ),
        ),
      ],
    );
  }
}
