import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodage/ui/camera/bar/camera_preview_bar.dart';
import 'package:foodage/ui/camera/photo_container.dart';
import 'package:foodage/ui/widgets/fdg_button.dart';
import 'package:foodage/ui/widgets/fdg_ratio.dart';

class FoodCamera extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FoodCameraState();
  }

}

class FoodCameraState extends State<FoodCamera> {

  @override
  Widget build(BuildContext context) {
    final contextThemeData = Theme.of(context);
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
                                        Theme(
                                          data: contextThemeData.copyWith(
                                            textTheme: contextThemeData.textTheme.copyWith(
                                              button: contextThemeData.textTheme.button.copyWith(
                                                fontSize: 13
                                              )
                                            )
                                          ),
                                          child: FDGPrimaryButton(
                                            "Doorgaan",
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 20
                                            ),
                                            borderRadius: 8,
                                            onTap: (BuildContext context) {

                                            },
                                          ),
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
            CameraPreviewBar()
            //CameraCaptureBar()
          ],
        ),
      ),
    );
  }

}