import 'package:flutter/material.dart';
import '../../ui_extensions.dart';
import '../../widgets/fdg_button.dart';
import 'camera_bar.dart';

class CameraPreviewBar extends StatelessWidget {
  final WidgetTapCallback onCancelPressed;
  final WidgetTapCallback onUsePhotoPressed;

  CameraPreviewBar({required this.onCancelPressed, required this.onUsePhotoPressed});

  @override
  Widget build(BuildContext context) {
    return CameraBarContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FDGSecondaryButton(
            "Annuleren",
            icon: Container(
              child: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
              margin: EdgeInsets.only(left: 5),
            ),
            buttonStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white60)
            ),
            borderRadius: 14,
            textPadding: EdgeInsets.symmetric(horizontal: 10),
            onTap: onCancelPressed,
          ),
          SizedBox(
            width: 16,
          ),
          FDGPrimaryButton(
            "Gebruik foto",
            icon: Container(
              child: Icon(Icons.check, color: Theme.of(context).textTheme.button!.color),
              margin: EdgeInsets.only(left: 5),
            ),
            borderRadius: 14,
            textPadding: EdgeInsets.symmetric(horizontal: 10),
            onTap: onUsePhotoPressed,
          )
        ],
      ),
    );
  }
}
