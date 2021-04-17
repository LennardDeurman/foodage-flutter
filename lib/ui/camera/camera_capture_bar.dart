import 'package:flutter/material.dart';
import 'package:foodage/ui/extensions.dart';

class _CaptureButton extends StatelessWidget {
  final double size;
  final double innerMargin;
  final Color buttonColor;
  final Color borderColor;
  final WidgetTapCallback onTap;

  const _CaptureButton({
    @required this.onTap,
    @required this.size,
    this.innerMargin = 2,
    this.buttonColor = Colors.white,
    this.borderColor = Colors.grey,
  });

  double get _innerSize => size - innerMargin;

  double get _innerBorderRadius => _innerSize / 2;

  double get _borderRadius => size / 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: buttonColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onTap != null ? onTap(context) : null,
            child: Container(
              width: size,
              height: size,
              child: Center(
                child: Container(
                  width: _innerSize,
                  height: _innerSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_innerBorderRadius),
                    border: Border.all(color: borderColor, width: innerMargin),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectFromGalleryButton extends StatelessWidget {

  static const _width = 65.0;
  static const _imageHeight = 45.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Material(
              child: InkWell(
                onTap: () {

                },
                child: Container(
                  width: _width,
                  height: _imageHeight,
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              "Selecteren uit gallerij",
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(
                top: 8,
            ),
          )
        ],
      ),
    );
  }

}

class CameraCaptureBar extends StatelessWidget {

  static const _captureButtonSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(95, 95, 95, 1),
      height: 140,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: _SelectFromGalleryButton(),
                margin: EdgeInsets.symmetric(
                    horizontal: 20
                ),
              )
          ),
          Align(
            alignment: Alignment.center,
            child: _CaptureButton(
              size: _captureButtonSize,
            ),
          )
        ],
      ),
    );
  }

}
