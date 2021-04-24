import 'package:flutter/material.dart';
import '../../ui/extensions.dart';
import '../../ui/widgets/fdg_ratio.dart';

class _CloseButton extends StatelessWidget {

  final double size;
  final double buttonInnerMargin;
  final WidgetTapCallback onRemovePressed;

  _CloseButton ({ @required this.size, @required this.onRemovePressed, this.buttonInnerMargin = 5 });

  double get _borderRadius => size / 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: Material(
          color: Theme.of(context).primaryColor,
          child: InkWell(
            child: Container(
              child: Center(
                child: Icon(Icons.close, color: Colors.white, size: size - buttonInnerMargin),
              ),
            ),
            onTap: () => onRemovePressed(context),
          ),
        ),
      ),
    );
  }

}

class PhotoContainer extends StatelessWidget {

  final WidgetTapCallback onRemovePressed;
  final double borderRadius;

  static const _backgroundColor = Color.fromRGBO(100, 100, 100, 1);
  static const _closeButtonSize = 20.0;


  PhotoContainer ({ this.borderRadius = 10, this.onRemovePressed });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)
      ),
      child: FDGRatio(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: _backgroundColor,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 10,
                top: -8,
                child: _CloseButton(
                  size: _closeButtonSize,
                  onRemovePressed: onRemovePressed,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}