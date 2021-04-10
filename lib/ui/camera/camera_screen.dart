import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodCamera extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FoodCameraState();
  }

}

typedef _WidgetTapAction = Function(BuildContext context);

class _CaptureButton extends StatelessWidget {

  final double size;
  final double innerMargin;
  final Color buttonColor;
  final Color borderColor;
  final _WidgetTapAction onTap;

  _CaptureButton ({ this.size = 50, this.innerMargin = 2, this.buttonColor = Colors.white, this.borderColor = Colors.grey, this.onTap });

  double get _innerSize => size - innerMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: buttonColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size / 2)
          ),
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
                      borderRadius: BorderRadius.circular(_innerSize / 2),
                      border: Border.all(
                          color: borderColor,
                          width: innerMargin
                      )
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

  final double width;
  final double imageHeight;

  _SelectFromGalleryButton ({ this.width = 65, this.imageHeight = 45 });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: this.width,
            height: this.imageHeight,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
          ),
          Container(
            child: Text(
              "Selecteren uit gallerij",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
            margin: EdgeInsets.only(
                top: 8
            ),
          )
        ],
      ),
    );
  }

}

class _CameraCaptureBar extends StatelessWidget {

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
            child: _CaptureButton(),
          )
        ],
      ),
    );
  }

}

class FoodCameraState extends State<FoodCamera> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            _CameraCaptureBar()
          ],
        ),
      ),
    );
  }

}