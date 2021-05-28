import 'package:flutter/material.dart';
import 'package:foodage/ui/fdg_theme.dart';

import '../../ui/ui_extensions.dart';
import '../../ui/widgets/fdg_ratio.dart';

class _ActionButton extends StatelessWidget {
  final double size;
  final double buttonInnerMargin;
  final Color color;
  final Icon icon;
  final WidgetTapCallback onPressed;

  _ActionButton({
    required this.size,
    required this.color,
    required this.onPressed,
    required this.icon,
    this.buttonInnerMargin = 5,
  });

  double get _borderRadius => size / 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: Material(
          color: color,
          child: InkWell(
            child: Container(
              child: Center(
                child: IconTheme(
                  data: IconThemeData(
                    color: Colors.white,
                    size: size - buttonInnerMargin,
                  ),
                  child: icon,
                ),
              ),
            ),
            onTap: () => onPressed(context),
          ),
        ),
      ),
    );
  }
}

class PhotoContainer extends StatelessWidget {
  final WidgetTapCallback? onRemovePressed;
  final WidgetTapCallback? onEditPressed;
  final double borderRadius;
  final Widget content;

  static const _backgroundColor = Color.fromRGBO(100, 100, 100, 1);
  static const _buttonSize = 20.0;

  PhotoContainer({
    required this.content,
    this.borderRadius = 10,
    this.onRemovePressed,
    this.onEditPressed,
  });

  Widget _actionButtonRemove(BuildContext context) => _ActionButton(
        size: _buttonSize,
        color: Theme.of(context).primaryColor,
        icon: Icon(Icons.close),
        onPressed: onRemovePressed!,
      );

  Widget _actionButtonEdit(BuildContext context) => _ActionButton(
    size: _buttonSize,
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
