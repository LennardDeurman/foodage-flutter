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
            Container(
              color: Color.fromRGBO(98, 95, 95, 1),
              padding: EdgeInsets.symmetric(
                vertical: 40
              ),
              child: Center(
                child: _CaptureButton(
                  onTap: (BuildContext context) {
                    print("capture photo");
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}