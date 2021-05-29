import 'package:flutter/material.dart';
import 'package:foodage/ui/widget_tap_callback.dart';

class FDGBadgeActionButton extends StatelessWidget {
  final double size;
  final double buttonInnerMargin;
  final Color color;
  final Icon icon;
  final WidgetTapCallback onPressed;

  FDGBadgeActionButton({

    required this.color,
    required this.onPressed,
    required this.icon,
    this.size = 20,
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