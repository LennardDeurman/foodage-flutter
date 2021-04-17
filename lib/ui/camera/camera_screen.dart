import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodage/ui/camera/photo_container.dart';
import 'package:foodage/ui/widgets/fdg_button.dart';
import 'package:foodage/ui/widgets/fdg_ratio.dart';

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
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        FDGRatio(),
                      ],
                    )
                  ),
                  Positioned.fill(
                    child: Column(
                      children: [
                        Expanded(
                          child: SafeArea(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ]
                              ),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            customBorder: new CircleBorder(),
                                            onTap: () {},
                                            splashColor: Colors.grey,
                                            child: new Icon(
                                              Icons.close,
                                              size: 24,
                                              color: Colors.black,
                                            ),
                                          )
                                        ),
                                        FDGButton(
                                          "Doorgaan",
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 20
                                          ),
                                          textStyle: Theme.of(context).textTheme.button.copyWith(
                                            fontSize: 13
                                          ),
                                          onTap: (BuildContext context) {

                                          },
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxHeight: 100,
                                            ),
                                            child: ListView.builder(
                                              clipBehavior: Clip.none,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (BuildContext context, int position) {
                                                return Container(
                                                  margin: EdgeInsets.only(right: 5),
                                                  child: PhotoContainer(),
                                                );
                                              },
                                              itemCount: 3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 5
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            child: Text("Media", style: Theme.of(context).textTheme.caption),
                                            margin: EdgeInsets.only(
                                              bottom: 3
                                            ),
                                          ),
                                          Text("3 geselecteerd", style: Theme.of(context).textTheme.subtitle2)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        FDGRatio(
                          child: Container(
                            color: Colors.transparent,
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _CameraCaptureBar()
          ],
        ),
      ),
    );
  }

}