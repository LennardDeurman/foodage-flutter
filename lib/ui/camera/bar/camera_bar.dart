import 'package:flutter/material.dart';

class CameraBarContainer extends StatelessWidget {

  final Widget child;
  final BoxDecoration decoration;

  static const _barHeight = 140.0;

  CameraBarContainer({ @required this.child, this.decoration });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      height: _barHeight,
      child: child,
    );
  }

}