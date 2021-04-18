import 'package:flutter/material.dart';
import 'package:foodage/ui/camera/bar/camera_bar.dart';
import 'package:foodage/ui/widgets/fdg_button.dart';

class CameraPreviewBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CameraBarContainer(
      child: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FDGSecondaryButton(
                "Annuleren",
                icon: Container(
                  child: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
                  margin: EdgeInsets.only(
                      left: 5
                  ),
                ),
                borderRadius: 14,
                textPadding: EdgeInsets.symmetric(
                    horizontal: 10
                ),
                onTap: (BuildContext context) {},
              ),
              SizedBox(width: 16,),
              FDGPrimaryButton(
                "Gebruik foto",
                icon: Container(
                  child: Icon(Icons.check, color: Theme.of(context).textTheme.button.color),
                  margin: EdgeInsets.only(
                      left: 5
                  ),
                ),
                borderRadius: 14,
                textPadding: EdgeInsets.symmetric(
                    horizontal: 10
                ),
                onTap: (BuildContext context) {},
              )
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white
      ),
    );
  }

}