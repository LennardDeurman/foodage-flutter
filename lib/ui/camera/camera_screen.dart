import 'package:flutter/material.dart';
import 'package:foodage/data/service_locator.dart';
import 'package:foodage/ui/camera/picker/logic/gallery_picker/gallery_picker_event_bloc.dart';
import 'package:foodage/ui/camera/picker/logic/gallery_picker/gallery_picker_events.dart';
import 'package:foodage/ui/camera/picker/logic/photo_picker_bloc.dart';
import 'package:foodage/ui/camera/picker/photo_picker_segments.dart';
import 'package:provider/provider.dart';

import '../../ui/widgets/fdg_button.dart';
import '../../ui/widgets/fdg_ratio.dart';
import '../camera/bar/camera_capture_bar.dart';
import '../camera/photo_container.dart';
import '../camera/picker/photo_picker_bottom_sheet.dart';

class FoodCamera extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FoodCameraState();
  }

}

class FoodCameraState extends State<FoodCamera> {

  Widget _buildImageBody(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final contextThemeData = Theme.of(context);
    return MultiProvider(
      providers: [
        Provider<PhotoPickerManagingBloc>(create: (_) {
          final photoPickerSegments = getPhotoPickerSegments(context);
          final bloc = PhotoPickerManagingBloc(
              GalleryPickerEventBloc(sl.get()),
              segments: photoPickerSegments,
              initialSelectedSegment: photoPickerSegments[0],
          );
          bloc.galleryPickerEventBloc.add(GalleryPickerInitEvent());
          return bloc;
        }, lazy: false,)
      ],
      child:  Scaffold(
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
                                            Text("3 geselecteerd", style: Theme.of(context).textTheme.subtitle1)
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
                            child: _buildImageBody(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CameraCaptureBar(
                onCaptureTap: (BuildContext context) {

                },
                onSelectFromGalleryTap: (BuildContext context) => PhotoPickerBottomSheet.show(context),
              )
            ],
          ),
        ),
      ),
    );
  }

}