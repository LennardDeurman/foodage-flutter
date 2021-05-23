import 'package:flutter/material.dart';

class CameraBarContainer extends StatelessWidget {

  final Widget child;
  final BoxDecoration? decoration;


  CameraBarContainer({ required this.child, this.decoration });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 40,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            child
          ],
        ),
        bottom: true,
        top: false,
      ),
    );
  }

}