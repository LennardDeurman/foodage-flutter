import 'package:flutter/material.dart';

class CameraBarContainer extends StatelessWidget {

  final Widget child;
  final BoxDecoration? decoration;

  static const _barHeight = 80.0;

  CameraBarContainer({ required this.child, this.decoration });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SafeArea(
        child: SizedBox(
          height: _barHeight,
          child: child,
        ),
        bottom: true,
        top: false,
      ),
    );
  }

}