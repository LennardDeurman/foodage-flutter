import 'package:flutter/material.dart';
import 'package:foodage/ui/fdg_theme.dart';
import 'package:foodage/ui/widgets/fdg_badge_action_button.dart';

import '../../ui/ui_extensions.dart';
import '../../ui/widgets/fdg_ratio.dart';
class PhotoContainer extends StatelessWidget {
  final WidgetTapCallback? onRemovePressed;
  final WidgetTapCallback? onEditPressed;
  final double borderRadius;
  final Widget content;

  static const _backgroundColor = Color.fromRGBO(100, 100, 100, 1);

  PhotoContainer({
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: FDGRatio(
              child: Container(
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                  ),
                  child: FittedBox(
                    child: content,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ),
        Positioned(
          top: -5,
          right: 10,
          child: Row(
            children: <Widget>[
              if (onEditPressed != null) _actionButtonEdit(context),
              if (onRemovePressed != null) _actionButtonRemove(context),
            ].intersperse(
              SizedBox(
                width: 8,
              ),
            ).toList()
          ),
        ),
      ],
    );
  }
}

extension IntersperseExtensions<T> on Iterable<T> {
  Iterable<T> intersperse(T element) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield element;
        yield iterator.current;
      }
    }
  }
}
