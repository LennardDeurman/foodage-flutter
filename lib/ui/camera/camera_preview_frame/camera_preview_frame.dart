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
            final controller = previewState.controller;
            var camera = controller!.value;
            // fetch screen size
            final size = MediaQuery.of(context).size;

            // calculate scale depending on screen and camera ratios
            // this is actually size.aspectRatio / (1 / camera.aspectRatio)
            // because camera preview size is received as landscape
            // but we're calculating for portrait orientation
            var scale = size.aspectRatio * camera.aspectRatio;

            // to prevent scaling down, invert the value
            if (scale < 1) scale = 1 / scale;

            return Transform.scale(
                scale: scale,
                child: Center(
                  child: CameraPreview(controller),
                ),
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