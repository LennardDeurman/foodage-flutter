import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../background_builder.dart';
import 'camera_preview_frame_cubit/camera_preview_frame_states.dart';
import 'camera_preview_frame_cubit/camera_preview_frame_cubit.dart';

class CameraPreviewFrame extends StatelessWidget {

  final BackgroundBuilder _backgroundBuilder = BackgroundBuilder();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraPreviewFrameCubit, CameraPreviewFrameState>(
        builder: (context, previewState) {
          final cameraState = previewState.cameraState;
          if (cameraState == CameraState.ready) {
            final controller = previewState.controller!;
            final scale = 1 / (controller.value.aspectRatio * MediaQuery.of(context).size.aspectRatio);
            return Transform.scale(
              scale: scale,
              alignment: Alignment.topCenter,
              child: CameraPreview(controller),
            );
          } else if (cameraState == CameraState.permissionsDenied) {
            return _backgroundBuilder.custom(
              title: _backgroundBuilder.labels.title(context, "Toestemming vereist!"),
              subtitle: _backgroundBuilder.labels.subtitle(context,
                "De app heeft geen toegang om de camera te gebruiken. Ga naar instellingen om toegang in te schakelen",
              ),
            );
          } else if (cameraState == CameraState.noCameraAvailable) {
            return _backgroundBuilder.custom(
              title: _backgroundBuilder.labels.title(context, "Geen camera beschikbaar"),
              subtitle: _backgroundBuilder.labels.subtitle(context,
                "De app kan geen camera vinden op dit toestel, en je kan daarom geen foto's zelf maken. Je kunt wel een foto gebruiken uit de gallerij rechtsonder.",
              ),
            );
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
    );
  }

}